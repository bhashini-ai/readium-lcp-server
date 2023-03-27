FROM lcp-builder:latest as lcp-builder

FROM alpine:latest
WORKDIR /
RUN apk add --no-cache gettext # envsubst

COPY --from=lcp-builder /lcp/build/bin/lcpserver /usr/bin/lcpserver
COPY --from=lcp-builder /lcp/build/bin/lsdserver /usr/bin/lsdserver
RUN ls -als /usr/bin/lcpserver && ls -als /usr/bin/lsdserver && ls -als /usr/bin/

ARG I18N=/messages
ARG CONFIG_PATH=/docker/config.yaml
ARG PROFILE=basic
ARG PORT
ARG SERVER_CMD=/usr/bin/lcpserver

COPY $I18N /i18n

# envsubst in init.sh
COPY $CONFIG_PATH /tmp/config.yaml
COPY /docker/init.sh /init.sh

ENV LOCALIZATION_FOLDER=/i18n

ENV LOCALIZATION_DEFAULT_LANGUAGE=en-US
ENV LOCALIZATION_LANGUAGES_ARRAY=[\"en-US\"]

ENV LCP_DATABASE_ROOT_PATH=/lcp/db
ENV LSD_DATABASE=sqlite3://file:$LCP_DATABASE_ROOT_PATH/lcp.sqlite?cache=shared&mode=rwc
ENV LCP_DATABASE=sqlite3://file:$LCP_DATABASE_ROOT_PATH/lsd.sqlite?cache=shared&mode=rwc

ENV READIUM_LCPSERVER_CONFIG=/config.yaml
ENV READIUM_LSDSERVER_CONFIG=/config.yaml

ENV PROFILE=$PROFILE
ENV SERVER_CMD=$SERVER_CMD

EXPOSE $PORT

RUN chmod +x /init.sh
CMD /init.sh $SERVER_CMD

