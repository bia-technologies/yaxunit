---
sidebar_position: 1
---

# Руководство разработчика

Здесь будут собраны материалы по доработке тестового движка.

## Окружение

- Разработка ведется с использованием [1С:Enterprise Development Tools](https://edt.1c.ru/) актуальной релизной версии
- После клонирования репозитория, необходимо подключить `precommit4onec`
  - Установить [oscript](https://oscript.io/)
  - Установить precommit4onec `opm install precommit4onec`
  - Подключить precommit4onec к репозиторию `precommit4onec install -source-dir "exts" /путь/к/склонированному/репозиторию`. Например: путь к склонированному репозиторию '/home/valery/reps/yaxunit', то команда будет `precommit4onec install -source-dir "exts" ~/reps/yaxunit`

## Тестирование

Для прогона тестов используется [доработанная демо-конфигурация](https://github.com/bia-technologies/yaxunit/tree/develop/fixtures/demo-configuration) от фирмы  [1С](https://github.com/1C-Company).

Вам необходимо импортировать ее в рабочую область и привязать к ней проект yaxunit, запустить тесты.
