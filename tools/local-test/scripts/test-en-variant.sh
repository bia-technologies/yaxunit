#!/bin/bash
# ==============================================================================
# test-en-variant.sh — прогон всех самотестов YAxUnit на en-варианте встроенного
# языка (issue #705).
#
# ИЗОЛЯЦИЯ: скрипт работает ТОЛЬКО с собственной файловой ИБ этого worktree:
#   build/en-variant/file-db (+ build/en-variant/ibsrv-data, ssh_host_key, ibsrv.log).
#   Общая среда основного чекаута (/data/home/korav/projects/yaxunit: его filedb,
#   ibsrv на 8314/1543/1541) НЕ трогается вообще: свой экземпляр ibsrv поднимается
#   на других портах (web 8315, ssh-gate 1544, direct 1542 — рецепт п.12 навыка
#   yaxunit-ib-tests), свои каталоги, свой host-ключ. Никаких push в чужие базы.
#
# Механика:
#   1. Read-only проверки: утилиты, чистота Configuration.mdo по git,
#      ~/.1cv8/.../conf/conf.cfg (без него полный прогон зависает на подключении
#      внешних обработок — навык yaxunit-ib-tests, п.6).
#   2. Создаёт worktree-локальный v8project.local.yaml с двумя целями:
#        enpush — File=<worktree>/build/en-variant/file-db (push/extensions/create,
#                 провайдер ibcmd — designer на этой машине падает по клиентской
#                 лицензии, HASP недоступен, навык п.7);
#        origin — web-only standalone (web.url :8315) — тестовый клиент получает
#                 лицензию только через /WS web-публикацию (навык п.2: connection-
#                 строка ломает выдачу лицензии; прямой file-коннект тонкого клиента
#                 требует клиентскую лицензию, которой нет).
#      Файл в .gitignore, репо не загрязняет.
#   3. Первичная инициализация ИБ (один раз): `v8-runner --infobase enpush infobase
#      create` (EDT→XML конвертация + ibcmd) — база создаётся с en-конфигурацией.
#      Повторные запуски переиспользуют базу: полный `push --force` всех наборов
#      (смена scriptVariant — структурное изменение; --force также снимает вопросы
#      памяти после смены веток/фикстуры).
#   4. Временно правит fixtures/demo-configuration/.../Configuration.mdo:
#      scriptVariant Russian → English (резервная копия + гарантированный откат
#      через trap EXIT/INT/TERM; при грязном по git файле скрипт отказывается).
#   5. Снимает безопасный режим с расширений (extensions --name ...), поднимает
#      СВОЙ ibsrv (только свой pid — через pid-файл; чужие процессы не ищем и не
#      трогаем, правило AGENTS 3.1).
#   6. Прогоняет ВСЕ самотесты: xvfb-run + v8-runner --infobase origin
#      test yaxunit all --no-push (ИБ подготовлена push'ом этого же запуска —
#      правило AGENTS 2.2 о легитимности --no-push).
#   7. Сохраняет артефакты (jUnit-отчёт, логи прогона, патч фикстуры, контекст)
#      в build/en-variant-report/<дата-время>/.
#      ВАЖНО: v8-runner удаляет каталог УСПЕШНОГО прогона сразу после парсинга
#      отчёта (навык yaxunit-ib-tests, п.10) — на зелёном прогоне report.xml
#      недоступен, успех определяется кодом возврата v8-runner.
#   8. Проверяет маркер "ВстроенныйЯзык: en" (в jUnit-отчёте <property name=
#      "ВстроенныйЯзык" value="..."/> и в runner.log) — проверяемое различие
#      (AGENTS 2.2): если "ru", прогон шёл не на en-варианте и ничего не доказывает.
#   9. Останавливает свой ibsrv, восстанавливает RU-фикстуру. Локальная ИБ
#      ОСТАЁТСЯ в en-варианте (она изолирована и принадлежит этому скрипту;
#      для повторного прогона достаточно запустить скрипт снова — он сделает
#      push --force актуальных исходников). Удалить ИБ полностью:
#      rm -rf build/en-variant build/en-variant-report.
#
# Коды возврата:
#   0   — успех: тесты зелёные, en-вариант подтверждён, фикстура восстановлена;
#   1   — падение тестов (failures/errors > 0 или ненулевой код v8-runner);
#   2   — ошибка окружения/подготовки (precheck, создание ИБ, push, ibsrv);
#   3   — прогон выполнен, но en-вариант НЕ подтверждён (ВстроенныйЯзык: ru) —
#         результат такого прогона недействителен;
#   130 — скрипт прерван сигналом (фикстура восстановлена, свой ibsrv остановлен).
#
# Переменные окружения (необязательные переопределения):
#   EN_TEST_TIMEOUT  — таймаут прогона тестов в секундах (по умолчанию 2700);
#   EN_RECREATE_DB   — 1: пересоздать ИБ с нуля (infobase create) перед прогоном
#                      (по умолчанию 0 — переиспользовать существующую);
#   EN_V8_RUNNER     — путь к бинарнику v8-runner (по умолчанию из PATH).
#
# Режим --check: только read-only проверки окружения (ничего не правит,
# не создаёт, не запускает ibsrv и платформу).
# ==============================================================================

set -u

SCRIPTPATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"
ROOT_PATH="$(cd -- "$SCRIPTPATH/../../.." >/dev/null 2>&1 && pwd -P)"

MDO_REL='fixtures/demo-configuration/src/Configuration/Configuration.mdo'
MDO="$ROOT_PATH/$MDO_REL"
LOCAL_YAML="$ROOT_PATH/v8project.local.yaml"

# --- изолированная среда этого worktree ----------------------------------------
ENV_DIR="$ROOT_PATH/build/en-variant"     # file-db, ibsrv-data, ssh_host_key, ibsrv.log
FILE_DB="$ENV_DIR/file-db"
IB_DATA="$ENV_DIR/ibsrv-data"
SSH_KEY="$ENV_DIR/ssh_host_key"
IBSRV_LOG="$ENV_DIR/ibsrv.log"
IBSRV_PID_FILE="$ENV_DIR/ibsrv.pid"       # pid СВОЕГО ibsrv (никаких чужих процессов)

REF_NAME="yaxuniten"                       # имя ИБ для --name ibsrv
WEB_URL="http://localhost:8315"
HTTP_PORT="8315"
SSH_PORT="1544"                            # ssh-gate (не используется v8-runner в бою,
                                           # нужен самому ibsrv)
DIRECT_REGPORT="1542"                      # прямой порт сервера (8314→8315, 1543→1544, 1541→1542,
                                           # рецепт п.12 навыка yaxunit-ib-tests)
EN_PUSH_TARGET="enpush"                    # имя push-цели в local yaml
EN_TEST_TARGET="origin"                    # имя test-цели (web-only) в local yaml

V8_RUNNER="${EN_V8_RUNNER:-v8-runner}"
EN_TEST_TIMEOUT="${EN_TEST_TIMEOUT:-2700}"
EN_RECREATE_DB="${EN_RECREATE_DB:-0}"
CHECK_ONLY=0
[ "${1:-}" = "--check" ] && CHECK_ONLY=1

# --- состояние, которое восстанавливает trap -----------------------------------
MDO_BACKUP=""          # резервная копия исходного Configuration.mdo
TMP_DIR=""             # временный каталог (резервная копия)
REPORT_DIR=""          # каталог артефактов прогона
INTERRUPTED=0
IBSRV_BIN=""
IBSRV_STARTED_BY_US=0  # этот запуск скрипта поднял ibsrv

# ==============================================================================
# Вспомогательные функции
# ==============================================================================

die() { # $1 — код, $2 — сообщение
    >&2 echo "ОШИБКА: $2"
    exit "$1"
}

log()  { echo "== $*"; }
step() { echo; echo "=========== $* ==========="; }

# --- итоги jUnit-отчёта ---------------------------------------------------------

junit_totals() { # $1 — report.xml; вывод: "suites tests failures errors skipped"
    awk '
        function val(attr,    m) {
            if (match($0, attr "=\"[0-9]+\"")) {
                m = substr($0, RSTART, RLENGTH)
                gsub(/[^0-9]/, "", m)
                return m + 0
            }
            return 0
        }
        /<testsuite / {
            suites++
            tests += val("tests")
            failures += val("failures")
            errors += val("errors")
            skipped += val("skipped")
        }
        END { printf "%d %d %d %d %d\n", suites + 0, tests + 0, failures + 0, errors + 0, skipped + 0 }
    ' "$1" 2>/dev/null
}

# маркер языка: (а) <property name="ВстроенныйЯзык" value="en"/> в jUnit-отчёте,
# (б) строка "ВстроенныйЯзык: en" в runner.log прогона
lang_marker() { # $1... — файлы (report.xml / runner.log); вывод: ru | en | пусто
    local f m
    for f in "$@"; do
        [ -f "$f" ] || continue
        m="$(sed -n 's/.*name="ВстроенныйЯзык" value="\([a-zA-Z]*\)".*/\1/p' "$f" 2>/dev/null | head -1)"
        [ -n "$m" ] && { printf '%s' "$m"; return 0; }
        m="$(sed -n 's/.*ВстроенныйЯзык:[[:space:]]*\([a-zA-Z]*\).*/\1/p' "$f" 2>/dev/null | head -1)"
        [ -n "$m" ] && { printf '%s' "$m"; return 0; }
    done
    return 0
}

# ==============================================================================
# Проверки окружения (read-only)
# ==============================================================================

precheck_tools() {
    step "Проверка утилит"
    local missing=()
    for t in git curl ss pgrep ps awk sed tee timeout mktemp cmp setsid xvfb-run ssh-keygen; do
        command -v "$t" >/dev/null 2>&1 || missing+=("$t")
    done
    command -v "$V8_RUNNER" >/dev/null 2>&1 || missing+=("v8-runner($V8_RUNNER)")
    if [ "${#missing[@]}" -gt 0 ]; then
        die 2 "не найдены утилиты: ${missing[*]}"
    fi
    "$V8_RUNNER" --version >/dev/null 2>&1 || die 2 "v8-runner не запускается"
    log "утилиты на месте"
}

resolve_paths() {
    step "Пути и каталоги"
    [ -f "$ROOT_PATH/v8project.yaml" ] || die 2 "нет $ROOT_PATH/v8project.yaml (запуск из репо YAxUnit?)"
    [ -f "$MDO" ] || die 2 "нет фикстуры $MDO"
    git -C "$ROOT_PATH" rev-parse --git-common-dir >/dev/null 2>&1 || die 2 "$ROOT_PATH не git-репозиторий"
    log "worktree:      $ROOT_PATH"
    log "локальная ИБ:  $FILE_DB (изолирована от основного чекаута)"
    log "свой ibsrv:    web :$HTTP_PORT, ssh :$SSH_PORT, direct :$DIRECT_REGPORT"
}

check_mdo() {
    step "Проверка фикстуры configuration"
    # отказ, если рабочая копия уже грязная по этому файлу — не затираем чужие правки
    if [ -n "$(git -C "$ROOT_PATH" status --porcelain -- "$MDO_REL" 2>/dev/null)" ]; then
        die 2 "$MDO_REL уже изменён в рабочей копии — отказ (не затираю чужие правки)"
    fi
    local n
    n="$(grep -c '<scriptVariant>Russian</scriptVariant>' "$MDO" || true)"
    [ "$n" = "1" ] || die 2 "ожидался ровно один <scriptVariant>Russian</scriptVariant> в Configuration.mdo, найдено: $n"
    log "фикстура чиста по git, scriptVariant=Russian (1 вхождение)"
}

check_conf_cfg() {
    step "Проверка conf.cfg платформы"
    local cfg="$HOME/.1cv8/1C/1cv8/conf/conf.cfg"
    if [ -f "$cfg" ] && grep -q 'DisableUnsafeActionProtection' "$cfg"; then
        log "DisableUnsafeActionProtection установлен ($cfg)"
    else
        die 2 "нет DisableUnsafeActionProtection в $cfg — полный прогон зависнет на подключении внешних обработок (навык yaxunit-ib-tests, п.6). Исправление: mkdir -p ~/.1cv8/1C/1cv8/conf/ && echo \"DisableUnsafeActionProtection=.*\" >> $cfg"
    fi
}

check_ports_free() {
    step "Проверка портов своего ibsrv (:$HTTP_PORT :$SSH_PORT :$DIRECT_REGPORT)"
    local p occupied
    for p in "$HTTP_PORT" "$SSH_PORT" "$DIRECT_REGPORT"; do
        occupied="$(ss -tln 2>/dev/null | grep -E "[:.]$p[[:space:]]" || true)"
        if [ -n "$occupied" ]; then
            die 2 "порт :$p занят ( $occupied) — выберите другие порты (EN-скрипт держит свой ibsrv на 8315/1544/1542; общий ibsrv машины использует 8314/1543/1541 — его не трогаем)"
        fi
    done
    log "порты свободны"
}

# ==============================================================================
# Локальный конфиг v8-runner (цели enpush/origin)
# ==============================================================================

ensure_local_yaml() {
    step "v8project.local.yaml ($LOCAL_YAML)"
    if [ -f "$LOCAL_YAML" ]; then
        # конфиг мог остаться от чужого/прошлого запуска с другой формой — сверим цели
        if grep -q "^  $EN_PUSH_TARGET:" "$LOCAL_YAML" && grep -q "^  $EN_TEST_TARGET:" "$LOCAL_YAML"; then
            log "уже существует, цели $EN_PUSH_TARGET/$EN_TEST_TARGET объявлены — используется как есть"
            return 0
        fi
        if [ "$CHECK_ONLY" = "1" ]; then
            log "существует, но без целей $EN_PUSH_TARGET/$EN_TEST_TARGET; в боевом режиме будет перезаписан"
            return 0
        fi
        log "существует, но без нужных целей — перезаписываю (файл в .gitignore, генерируется скриптом)"
    elif [ "$CHECK_ONLY" = "1" ]; then
        log "отсутствует; в боевом режиме будет создан"
        return 0
    fi

    cat > "$LOCAL_YAML" <<EOL || die 2 "не удалось записать $LOCAL_YAML"
# yaml-language-server: \$schema=https://raw.githubusercontent.com/IngvarConsulting/v8-runner-rust/master/docs/schemas/v8project.local.schema.json
# Создан test-en-variant.sh (issue #705, en-вариант). Изолированная среда этого worktree:
#   enpush — файловая ИБ build/en-variant/file-db (push/extensions/infobase create, ibcmd);
#   origin — web-only standalone: тестовый клиент идёт по /WS http://localhost:8315
#   (лицензии ibsrv выдаются только через web-публикацию — навык yaxunit-ib-tests, п.2).
# Свой ibsrv (порты 8315/1544/1542, НЕ общего 8314/1543/1541):
#   setsid nohup <ibsrv> --db-path=$FILE_DB --data=$IB_DATA --name=$REF_NAME \\
#     --http-port=$HTTP_PORT --ssh-address=127.0.0.1 --ssh-port=$SSH_PORT \\
#     --ssh-host-key=$SSH_KEY --direct-regport=$DIRECT_REGPORT \\
#     > $IBSRV_LOG 2>&1 < /dev/null & disown
infobases:
  $EN_PUSH_TARGET:
    connection: 'File=$FILE_DB'
  $EN_TEST_TARGET:
    standalone:
      gate: 'localhost:$SSH_PORT'
      exchange: sftp
    web:
      url: '$WEB_URL'
tools:
  platform:
    version: '8.3.27'
providers:
  push: ibcmd
EOL
    log "создан (цели $EN_PUSH_TARGET → $FILE_DB, $EN_TEST_TARGET → $WEB_URL)"
}

discover_ibsrv_bin() {
    step "Поиск бинарника ibsrv"
    # через v8-runner platforms на push-цели (действует providers.push: ibcmd; запуск из
    # каталога с local-конфигом; в --check без конфига — из worktree с временным пропуском)
    local json selected
    if [ -f "$LOCAL_YAML" ] || [ "$CHECK_ONLY" != "1" ]; then
        json="$(cd "$ROOT_PATH" && "$V8_RUNNER" --no-color --json-message \
            --infobase "$EN_PUSH_TARGET" platforms 2>/dev/null || true)"
    fi
    if [ -n "${json:-}" ]; then
        selected="$(printf '%s' "$json" | sed -n '/"selected":/,$p' \
            | grep -o '"path": *"[^"]*"' | sed 's/"path": *//; s/"//g' \
            | grep '/ibcmd$' | head -1 || true)"
        if [ -n "$selected" ]; then
            IBSRV_BIN="$(dirname "$selected")/ibsrv"
        fi
    fi
    # fallback: каталог платформы (на машине /opt/1cv8/x86_64/<version>/ibsrv)
    if [ -z "$IBSRV_BIN" ] || [ ! -x "$IBSRV_BIN" ]; then
        local cand
        for cand in /opt/1cv8/x86_64/8.3.27*/ibsrv; do
            [ -x "$cand" ] && IBSRV_BIN="$cand" && break
        done
    fi
    [ -n "$IBSRV_BIN" ] && [ -x "$IBSRV_BIN" ] || die 2 "бинарник ibsrv не найден (см. v8-runner platforms)"
    log "ibsrv: $IBSRV_BIN"
}

# ==============================================================================
# Управление СВОИМ ibsrv (v8-runner standalone-сервером не управляет — навык, п.1)
# ==============================================================================

our_ibsrv_pid() { # pid из pid-файла, если процесс жив; пусто иначе
    local pid
    [ -f "$IBSRV_PID_FILE" ] || return 0
    pid="$(head -1 "$IBSRV_PID_FILE" 2>/dev/null || true)"
    [ -n "$pid" ] || return 0
    if ps -p "$pid" -o args= 2>/dev/null | grep -q -- "--db-path=$FILE_DB"; then
        printf '%s' "$pid"
    fi
    return 0
}

stop_our_ibsrv() {
    step "Остановка своего ibsrv (pid-файл $IBSRV_PID_FILE)"
    local pid
    pid="$(our_ibsrv_pid)"
    if [ -z "$pid" ]; then
        rm -f "$IBSRV_PID_FILE"
        log "свой ibsrv не запущен"
        return 0
    fi
    log "останавливаю свой ibsrv (pid $pid)"
    kill -TERM "$pid" 2>/dev/null || true
    local i
    for i in $(seq 1 20); do
        ps -p "$pid" >/dev/null 2>&1 || break
        sleep 1
    done
    if ps -p "$pid" >/dev/null 2>&1; then
        log "ibsrv не завершился по TERM — посылаю KILL"
        kill -KILL "$pid" 2>/dev/null || true
        sleep 3
    fi
    ps -p "$pid" >/dev/null 2>&1 && die 2 "не удалось остановить свой ibsrv (pid $pid)"
    rm -f "$IBSRV_PID_FILE"
    # дожаться освобождения web-порта (свои сироты sm-searcher не трогаем — порт уйдёт сам;
    # если не ушёл — отказ, чужое не убиваем)
    for i in $(seq 1 10); do
        [ -z "$(ss -tln 2>/dev/null | grep -E "[:.]$HTTP_PORT[[:space:]]" || true)" ] && break
        sleep 1
    done
    if [ -n "$(ss -tln 2>/dev/null | grep -E "[:.]$HTTP_PORT[[:space:]]" || true)" ]; then
        log "ВНИМАНИЕ: порт :$HTTP_PORT ещё слушается после остановки ibsrv (возможна сирота sm-searcher с -Droot=$IB_DATA — можно остановить вручную по навыку yaxunit-ib-tests п.9)"
    fi
    log "свой ibsrv остановлен"
}

start_our_ibsrv() {
    step "Запуск своего ibsrv (web :$HTTP_PORT, direct :$DIRECT_REGPORT)"
    [ -x "$IBSRV_BIN" ] || die 2 "нет бинарника ibsrv: $IBSRV_BIN"
    [ -d "$FILE_DB" ] || die 2 "нет файловой ИБ: $FILE_DB (create не выполнен?)"
    # свой host-ключ; создаём при первом запуске (навык п.1: дефолтный ~/.ssh/id_rsa
    # платформа не принимает; отпечаток в конфиге не используется — gate в бою не нужен)
    if [ ! -f "$SSH_KEY" ]; then
        log "генерирую свой host-ключ $SSH_KEY"
        mkdir -p "$ENV_DIR"
        ssh-keygen -t rsa -b 2048 -N "" -f "$SSH_KEY" -C en-variant-ibsrv >/dev/null 2>&1 \
            || die 2 "ssh-keygen не смог создать $SSH_KEY"
    fi
    # порты: занятость уже проверена в check_ports_free (боевой режим)
    mkdir -p "$ENV_DIR" "$(dirname "$IBSRV_LOG")"

    # только абсолютные пути; иначе ibsrv падает по lock-файлу (навык, п.1)
    setsid nohup "$IBSRV_BIN" \
        --db-path="$FILE_DB" --data="$IB_DATA" --name="$REF_NAME" \
        --http-port="$HTTP_PORT" \
        --ssh-address=127.0.0.1 --ssh-port="$SSH_PORT" --ssh-host-key="$SSH_KEY" \
        --direct-regport="$DIRECT_REGPORT" \
        > "$IBSRV_LOG" 2>&1 < /dev/null &
    local launcher_pid=$!
    disown 2>/dev/null || true
    # setsid форкает: pidобёртки != pid ibsrv. Найдём настоящий pid по db-path + портам.
    local i real_pid
    real_pid=""
    for i in $(seq 1 30); do
        sleep 1
        real_pid="$(pgrep -f "ibsrv --db-path=$FILE_DB" 2>/dev/null | head -1 || true)"
        [ -n "$real_pid" ] && break
    done
    [ -n "$real_pid" ] || die 2 "свой ibsrv не стартовал (лог: $IBSRV_LOG)"
    echo "$real_pid" > "$IBSRV_PID_FILE"
    log "свой ibsrv запущен (pid $real_pid, лог: $IBSRV_LOG)"

    # ожидание web-ответа
    local code
    code=""
    for i in $(seq 1 60); do
        code="$(curl -s -o /dev/null -w "%{http_code}" --max-time 3 "$WEB_URL" 2>/dev/null || true)"
        [ "$code" = "200" ] && break
        # процесс мог умереть — не ждать вхолостую
        ps -p "$real_pid" >/dev/null 2>&1 || break
    done
    [ "$code" = "200" ] || die 2 "свой ibsrv не поднялся на $WEB_URL (лог: $IBSRV_LOG)"

    # пробник логина: здоровый сервер отвечает 400/409 быстро (навык, п.8);
    # data-каталог наш и свежий, но проверка бесплатна
    local ver probe
    ver="$(basename "$(dirname "$IBSRV_BIN")")"
    probe="$(curl -s --max-time 15 -o /dev/null -w "%{http_code}" \
        -X POST "$WEB_URL/e1cib/login?clnPid=1&clnId=envariant&vl=ru_RU&version=$ver" \
        -H "User-Agent: 1CV8C" 2>/dev/null || true)"
    case "$probe" in
        400|409) log "свой ibsrv поднят и здоров (web 200, login probe $probe)" ;;
        *) die 2 "ibsrv поднялся, но login probe = '$probe' (ожидался 400/409) — похоже на протухший data-каталог, см. навык yaxunit-ib-tests, п.8" ;;
    esac
}

# ==============================================================================
# Переключение фикстуры в en и гарантированный откат
# ==============================================================================

switch_mdo_to_english() {
    step "Переключение фикстуры configuration в scriptVariant=English"
    TMP_DIR="$(mktemp -d /tmp/en-variant.XXXXXX)" || die 2 "mktemp не удался"
    MDO_BACKUP="$TMP_DIR/Configuration.mdo.orig"
    cp "$MDO" "$MDO_BACKUP" || die 2 "не удалось сохранить резервную копию $MDO"
    sed -i 's|<scriptVariant>Russian</scriptVariant>|<scriptVariant>English</scriptVariant>|' "$MDO" \
        || die 2 "sed не смог править $MDO"
    grep -q '<scriptVariant>English</scriptVariant>' "$MDO" \
        || { cp "$MDO_BACKUP" "$MDO"; die 2 "правка не применилась — откат выполнен"; }
    log "English-вариант применён (резерв: $MDO_BACKUP)"
    git -C "$ROOT_PATH" diff -- "$MDO_REL" > "$REPORT_DIR/en-variant.patch" || true
}

restore_mdo() {
    if [ -n "$MDO_BACKUP" ] && [ -f "$MDO_BACKUP" ]; then
        if ! cmp -s "$MDO_BACKUP" "$MDO"; then
            cp "$MDO_BACKUP" "$MDO" 2>/dev/null || true
        fi
        if cmp -s "$MDO_BACKUP" "$MDO"; then
            rm -f "$MDO_BACKUP"
            log "фикстура configuration восстановлена (RU)"
        else
            [ -n "$REPORT_DIR" ] && cp "$MDO_BACKUP" "$REPORT_DIR/Configuration.mdo.rescue" 2>/dev/null || true
            >&2 echo "ОШИБКА: не удалось восстановить $MDO_REL! Резервная копия: ${REPORT_DIR:-?}/Configuration.mdo.rescue (или $MDO_BACKUP)"
        fi
    fi
}

# ==============================================================================
# Trap: откат фикстуры, остановка СВОЕГО ibsrv
# ==============================================================================

on_exit() {
    local rc=$?
    trap - EXIT INT TERM
    if [ "$IBSRV_STARTED_BY_US" = "1" ]; then
        stop_our_ibsrv 2>/dev/null || log "ВНИМАНИЕ: не удалось остановить свой ibsrv (см. $IBSRV_LOG)"
    fi
    restore_mdo
    if [ "$INTERRUPTED" = "1" ]; then
        echo
        echo "Скрипт прерван сигналом — фикстура восстановлена, свой ibsrv остановлен."
        rc=130
    fi
    [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ] && rmdir "$TMP_DIR" 2>/dev/null || true
    exit "$rc"
}

on_signal() {
    INTERRUPTED=1
    exit 130
}

# ==============================================================================
# Основной сценарий
# ==============================================================================

create_infobase() {
    step "Первичное создание локальной ИБ ($FILE_DB)"
    [ -e "$FILE_DB" ] && die 2 "$FILE_DB уже существует (не ожидалось; удалите или запустите без пересоздания)"
    mkdir -p "$ENV_DIR"
    ( cd "$ROOT_PATH" && "$V8_RUNNER" --infobase "$EN_PUSH_TARGET" infobase create 2>&1 \
        | tee "$REPORT_DIR/infobase-create.log"; exit "${PIPESTATUS[0]}" )
    local rc=$?
    if [ "$rc" -ne 0 ]; then
        die 2 "infobase create не удался (код $rc, лог: $REPORT_DIR/infobase-create.log)"
    fi
    log "локальная ИБ создана (en-конфигурация)"
}

push_all_sets() {
    step "Полный push всех наборов в $EN_PUSH_TARGET (en-конфигурация)"
    local rc
    ( cd "$ROOT_PATH" && "$V8_RUNNER" --infobase "$EN_PUSH_TARGET" push --force 2>&1 \
        | tee "$REPORT_DIR/push.log"; exit "${PIPESTATUS[0]}" )
    rc=$?
    if [ "$rc" -ne 0 ]; then
        die 2 "push --force не удался (код $rc, лог: $REPORT_DIR/push.log)"
    fi
    log "все наборы запушены (en-вариант конфигурации в локальной ИБ)"
}

set_extension_props() {
    step "Свойства расширений (safe-mode=off, защита от опасных действий=off)"
    local rc
    ( cd "$ROOT_PATH" && "$V8_RUNNER" --infobase "$EN_PUSH_TARGET" extensions \
        --name YAXUNIT --name Smoke --name tests 2>&1 \
        | tee "$REPORT_DIR/extensions.log"; exit "${PIPESTATUS[0]}" )
    rc=$?
    # не фатально: свойства могли сохраниться в базе от предыдущих прогонов
    [ "$rc" -ne 0 ] && log "ВНИМАНИЕ: extensions завершился с кодом $rc (см. $REPORT_DIR/extensions.log)"
    return 0
}

run_tests() {
    step "Прогон всех самотестов (тонкий клиент под xvfb, цель $EN_TEST_TARGET по $WEB_URL)"
    log "таймаут прогона: ${EN_TEST_TIMEOUT}s (переопределяется EN_TEST_TIMEOUT)"
    ( cd "$ROOT_PATH" \
        && timeout --signal=INT --kill-after=90 "$EN_TEST_TIMEOUT" \
            xvfb-run -a -s "-screen 0 1024x768x24" \
            "$V8_RUNNER" --infobase "$EN_TEST_TARGET" test yaxunit all --no-push 2>&1 \
            | tee "$REPORT_DIR/v8-runner-test.log"; exit "${PIPESTATUS[0]}" )
    TEST_RC=$?
    log "v8-runner завершился с кодом $TEST_RC"
}

collect_artifacts() {
    step "Сбор артефактов прогона"
    local runs_dir="$ROOT_PATH/build/temp/yaxunit/runs"
    local newest
    newest="$(ls -1t "$runs_dir" 2>/dev/null | head -1 || true)"
    if [ -n "$newest" ] && [ "$newest" != "$RUNS_NEWEST_BEFORE" ]; then
        RUN_DIR="$runs_dir/$newest"
        log "каталог прогона: $RUN_DIR"
        local f
        for f in report.xml runner.log enterprise.out.log config.json; do
            [ -f "$RUN_DIR/$f" ] && cp "$RUN_DIR/$f" "$REPORT_DIR/$f"
        done
        if [ -f "$REPORT_DIR/report.xml" ]; then
            mv "$REPORT_DIR/report.xml" "$REPORT_DIR/junit-report.xml"
            log "jUnit-отчёт: $REPORT_DIR/junit-report.xml"
        else
            log "report.xml в каталоге прогона отсутствует"
        fi
    else
        RUN_DIR=""
        log "новый каталог прогона не найден — вероятно, успешный прогон, чей каталог"
        log "авто-очищён v8-runner (навык yaxunit-ib-tests, п.10)"
    fi
}

print_failure_hints() {
    step "Диагностика (известные симптомы машины)"
    local out="$REPORT_DIR/enterprise.out.log"
    if [ -f "$out" ]; then
        if grep -q "Software license file not found" "$out"; then
            log "симптом: лицензия — перезапустить свой ibsrv, проверить зависшие 1cv8c (навык yaxunit-ib-tests, п.2)"
        fi
        if grep -q "Unable to initialize GTK" "$out"; then
            log "симптом: потерян X-сервер — проверь xvfb-обёртку команды прогона (навык, п.3)"
        fi
    fi
    if [ "$TEST_RC" -ne 0 ] && [ ! -f "$REPORT_DIR/junit-report.xml" ]; then
        log "jUnit не создан + ненулевой код — если падение быстрое, это лицензия, НЕ зависание (навык, п.6)"
    fi
}

print_summary() {
    step "Итог"
    {
        echo "Дата:            $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Ветка:           $(git -C "$ROOT_PATH" rev-parse --abbrev-ref HEAD 2>/dev/null)"
        echo "Коммит:          $(git -C "$ROOT_PATH" rev-parse HEAD 2>/dev/null)"
        echo "Локальная ИБ:    $FILE_DB"
        echo "v8-runner:       $TEST_RC"
        echo "jUnit:           suites=$SUITES tests=$TESTS failures=$FAILURES errors=$ERRORS skipped=$SKIPPED"
        echo "ВстроенныйЯзык:  ${LANG_MARKER:-неизвестен (артефакты недоступны)}"
        echo "ИБ осталась в en-варианте (изолирована, для повторного прогона просто запустить скрипт)"
    } | tee "$REPORT_DIR/summary.txt"
    echo
    echo "Артефакты: $REPORT_DIR"
}

main() {
    precheck_tools
    resolve_paths
    check_mdo
    check_conf_cfg
    ensure_local_yaml
    discover_ibsrv_bin
    check_ports_free

    if [ "$CHECK_ONLY" = "1" ]; then
        step "Режим --check: сводка (read-only)"
        if [ -d "$FILE_DB" ]; then
            log "локальная ИБ существует: $FILE_DB (повторный прогон переиспользует её)"
        else
            log "локальной ИБ нет — при боевом запуске будет создана (infobase create)"
        fi
        if [ -n "$(our_ibsrv_pid)" ]; then
            log "свой ibsrv сейчас запущен (pid-файл $IBSRV_PID_FILE)"
        else
            log "свой ibsrv остановлен"
        fi
        log "каталог прогонов: $ROOT_PATH/build/temp/yaxunit/runs (существует: $([ -d "$ROOT_PATH/build/temp/yaxunit/runs" ] && echo да || echo нет))"
        echo
        echo "Окружение готово к en-прогону. Боевой запуск: $0 (без аргументов)."
        exit 0
    fi

    # --- боевая часть -----------------------------------------------------------
    trap on_signal INT TERM
    trap on_exit EXIT

    RUNS_NEWEST_BEFORE="$(ls -1t "$ROOT_PATH/build/temp/yaxunit/runs" 2>/dev/null | head -1 || true)"

    REPORT_DIR="$ROOT_PATH/build/en-variant-report/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$REPORT_DIR" || die 2 "не удалось создать $REPORT_DIR"
    {
        echo "date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "branch: $(git -C "$ROOT_PATH" rev-parse --abbrev-ref HEAD 2>/dev/null)"
        echo "commit: $(git -C "$ROOT_PATH" rev-parse HEAD 2>/dev/null)"
        echo "dirty files: $(git -C "$ROOT_PATH" status --porcelain 2>/dev/null | wc -l)"
        echo "filedb: $FILE_DB"
        echo "ibsrv: $IBSRV_BIN (web :$HTTP_PORT, direct :$DIRECT_REGPORT)"
        echo "recreate_db: $EN_RECREATE_DB"
    } > "$REPORT_DIR/context.txt"

    # если свой ibsrv случайно остался от прошлого запуска — останавливаем (свой pid-файл)
    [ -n "$(our_ibsrv_pid)" ] && stop_our_ibsrv

    if [ ! -d "$FILE_DB" ] || [ "$EN_RECREATE_DB" = "1" ]; then
        if [ -d "$FILE_DB" ] && [ "$EN_RECREATE_DB" = "1" ]; then
            step "Пересоздание локальной ИБ (EN_RECREATE_DB=1)"
            rm -rf "$FILE_DB" "$IB_DATA" || die 2 "не удалось удалить старую $FILE_DB"
        fi
        create_infobase
    else
        log "локальная ИБ существует: $FILE_DB (переиспользуется)"
    fi

    switch_mdo_to_english
    push_all_sets
    set_extension_props
    start_our_ibsrv
    IBSRV_STARTED_BY_US=1

    TEST_RC=0
    SUITES=0; TESTS=0; FAILURES=0; ERRORS=0; SKIPPED=0
    LANG_MARKER=""
    RUN_DIR=""
    run_tests
    collect_artifacts
    print_failure_hints

    if [ -f "$REPORT_DIR/junit-report.xml" ]; then
        read -r SUITES TESTS FAILURES ERRORS SKIPPED <<< "$(junit_totals "$REPORT_DIR/junit-report.xml")"
        log "jUnit: наборов=$SUITES тестов=$TESTS падений=$FAILURES ошибок=$ERRORS пропущено=$SKIPPED"
    fi
    LANG_MARKER="$(lang_marker "$REPORT_DIR/junit-report.xml" "$REPORT_DIR/runner.log")"
    log "маркер ВстроенныйЯзык: ${LANG_MARKER:-не найден (артефакты прогона недоступны — успех по коду v8-runner)}"

    # --- вердикт ----------------------------------------------------------------
    stop_our_ibsrv
    IBSRV_STARTED_BY_US=0
    restore_mdo

    VERDICT=0
    if [ "$LANG_MARKER" = "ru" ]; then
        VERDICT=3
        >&2 echo "ОШИБКА: прогон выполнен на ru-варианте (ВстроенныйЯзык: ru) — en-фикстура не попала в ИБ; прогон ничего не доказывает (см. $REPORT_DIR/push.log)"
    elif [ "$TEST_RC" -ne 0 ] || [ "$((FAILURES + ERRORS))" -gt 0 ]; then
        VERDICT=1
    fi

    print_summary
    case "$VERDICT" in
        0) echo "РЕЗУЛЬТАТ: успех — en-прогон зелёный${LANG_MARKER:+ (ВстроенныйЯзык: $LANG_MARKER)}" ;;
        1) echo "РЕЗУЛЬТАТ: есть падения тестов — см. $REPORT_DIR/junit-report.xml" ;;
        3) echo "РЕЗУЛЬТАТ: en-вариант не подтверждён" ;;
    esac
    exit "$VERDICT"
}

main
