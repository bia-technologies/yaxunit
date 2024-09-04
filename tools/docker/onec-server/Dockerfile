FROM alpine:latest as downloader

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG ONEC_VERSION
ENV installer_type=server
ENV downloads=downloads/platform83/${ONEC_VERSION}

COPY ./scripts/download_og.sh /download_og.sh

WORKDIR /tmp
COPY ./distr ./${downloads}
RUN rm ./${downloads}/.gitkeep \
  && rm -rf ${downloads}/thin.client*.tar.gz \
  && rm -rf ${downloads}/client*.tar.gz \
  && rm -rf ${downloads}/1c_edt*.tar.gz \
  && if [ -z "$(ls -A ${downloads})" ]; then \
  apk --no-cache add bash curl grep tar \
  && set -x \
  && sync; /download_og.sh; \
  fi \
  && rm -rf ${downloads}/*thin*.tar.gz \
  && ls ${downloads} \
  && for file in ${downloads}/*.tar.gz; do tar -xzf "$file"; done \
  && rm -rf ${downloads}/*.*

FROM debian:bullseye-slim as base

ARG ONEC_VERSION
ENV installer_type=server
ARG gosu_ver=1.11
ARG nls_enabled=false
ENV nls=$nls_enabled

COPY ./scripts/install.sh /install.sh
COPY --from=downloader /tmp/*.* /tmp/
WORKDIR /tmp

SHELL ["/bin/bash", "-c"]
RUN ls . \
  && chmod +x /install.sh \
  && sync; /install.sh

# create symlink to current 1c:enterprise directory
COPY ./scripts/create-symlink-to-current-1cv8.sh /create-symlink-to-current-1cv8.sh
RUN chmod +x /create-symlink-to-current-1cv8.sh \
  && /create-symlink-to-current-1cv8.sh \
  && rm /create-symlink-to-current-1cv8.sh

ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu

RUN chmod +x /bin/gosu

FROM debian:bullseye-slim
LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG onec_uid="999"
ARG onec_gid="999"

COPY --from=base /opt /opt
COPY --from=base /bin/gosu /bin/gosu

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales \
      imagemagick \
      fontconfig \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

RUN groupadd -r grp1cv8 --gid=$onec_gid \
  && useradd -r -g grp1cv8 --uid=$onec_uid --home-dir=/home/usr1cv8 --shell=/bin/bash usr1cv8 \
  && mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf /opt/1cv8/current/conf \
  && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8

VOLUME /home/usr1cv8/.1cv8 /var/log/1C

COPY ./server/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf
COPY ./server/logcfg.xml /opt/1cv8/current/conf

COPY ./server/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 1540 1541 1545 1560
CMD ["ragent"]
