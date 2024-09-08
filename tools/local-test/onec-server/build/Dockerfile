# Создан на основании https://github.com/firstBitMarksistskaya/onec-docker/blob/feature/first-bit/server/Dockerfile

# Начало основной стадии сборки
FROM ubuntu:20.04 as installer

# Копируем скрипты и файлы установки
ARG ONEC_VERSION
ARG gosu_ver=1.11
ARG nls_enabled=false

ENV nls=$nls_enabled
ENV installer_type=server

# Установка зависимостей и настройка локали
RUN apt-get update \
&& apt-get install -yq \
      procps \
      tzdata \
      debconf-utils \
      curl \
      fontconfig \
      unixodbc \
      ttf-mscorefonts-installer \
      libgsf-1-114 \
      keyboard-configuration \
&& dpkg-reconfigure -f noninteractive tzdata \
&& dpkg-reconfigure -f noninteractive keyboard-configuration \
&& apt-get install -yq geoclue-2.0 gstreamer1.0-plugins-bad \
&& export LANG=ru_RU.UTF-8

COPY ./scripts/install_new.sh /install.sh
COPY ./distr/current /tmp

WORKDIR /tmp
RUN ls -ona \
  && chmod +x /install.sh \
  && sync; /install.sh

# Создание символической ссылки на текущую директорию 1C
COPY ./scripts/create-symlink-to-current-1cv8.sh /create-symlink-to-current-1cv8.sh
RUN chmod +x /create-symlink-to-current-1cv8.sh \
  && /create-symlink-to-current-1cv8.sh \
  && rm /create-symlink-to-current-1cv8.sh

# Установка gosu
ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu
RUN chmod +x /bin/gosu

# Переход к финальному образу
FROM ubuntu:20.04
LABEL maintainer="ivanov egor"

# Создание пользователя и установка локали
ARG onec_uid="999"
ARG onec_gid="999"
COPY --from=installer /opt/1cv8 /opt/1cv8
COPY --from=installer /bin/gosu /bin/gosu
RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales \
      iproute2 \
      imagemagick \
      fontconfig \
      ca-certificates \
  && rm -rf /var/lib/apt/lists/* /var/cache/debconf \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

# Настройка группы и пользователя
RUN groupadd -r grp1cv8 --gid=$onec_gid \
  && useradd -r -g grp1cv8 --uid=$onec_uid --home-dir=/home/usr1cv8 --shell=/bin/bash usr1cv8 \
  && mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf /opt/1cv8/current/conf \
  && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8

# Копирование конфигурационных файлов
COPY ./conf.cfg /home/usr1cv8/.1cv8/1C/1cv8/conf
COPY ./conf.cfg /opt/1cv8/current/conf

# Установка точки входа и выполнение дополнительных настроек
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh /  # backwards compat
RUN chmod +x /usr/local/bin/docker-entrypoint.sh 
RUN apt-get update && apt-get install -yq procps
RUN chmod +x /opt/1cv8/current/ragent

# Настройка точки входа и экспонирование портов
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
EXPOSE 1540 1541 1545 1560
CMD ["ragent"]
