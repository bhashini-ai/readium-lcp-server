FROM lcp-builder:latest as lcp-builder
FROM frontend-manage-builder:latest as frontend-manage-builder

FROM alpine:latest
WORKDIR /
RUN apk add --no-cache gettext # envsubst

COPY --from=lcp-builder /lcp/build/bin/lcpserver /usr/bin/lcpserver
COPY --from=lcp-builder /lcp/build/bin/lsdserver /usr/bin/lsdserver
COPY --from=lcp-builder /lcp/build/bin/frontend /usr/bin/frontend
COPY --from=frontend-manage-builder /lcp/build/frontend/manage/. /frontend/manage/.
RUN ls -als /usr/bin/lcpserver && ls -als /usr/bin/lsdserver && ls -als /usr/bin/frontend && ls -als /frontend/manage/ && ls -als /usr/bin/

ARG I18N=/messages
ARG AUTH_FILE=/test/htpasswd 
ARG PRIVATE_KEY_PATH=/test/cert/privkey-edrlab-test.pem
ARG CERTIFICATE_PATH=/test/cert/cert-edrlab-test.pem
ARG CONFIG_PATH=/docker/config.yaml
ARG PROFILE=basic
ARG PORT=8989
ARG SERVER_CMD=/usr/bin/lcpserver

COPY $PRIVATE_KEY_PATH /privkey.pem
COPY $CERTIFICATE_PATH /cert.pem
COPY $I18N /i18n
COPY $AUTH_FILE /htpasswd

# envsubst in inittab once
COPY $CONFIG_PATH /tmp/config.yaml
COPY /docker/init.sh /init.sh

ENV LCP_PORT=8989
ENV LCP_HOST=192.168.0.11
ENV LSD_PORT=8990
ENV LSD_HOST=192.168.0.11
ENV FRONTEND_PORT=8991
ENV FRONTEND_HOST=192.168.0.11

ENV AUTH_FILE=/htpasswd
ENV CERTIFICATE_PATH=/cert.pem
ENV PRIVATE_KEY=/privkey.pem
ENV LOCALIZATION_FOLDER=/i18n

ENV LOCALIZATION_DEFAULT_LANGUAGE=en-US
ENV LOCALIZATION_LANGUAGES_ARRAY=[\"en-US\"]

ENV LCP_DATABASE_ROOT_PATH=/lcp/db

ENV LSD_BASE_URL=http://192.168.0.11:8990/lsdserver
ENV LSD_NOTIFY_AUTH_USER=adm_username
ENV LSD_NOTIFY_AUTH_PASS=adm_password
ENV LSD_DATABASE=sqlite3://file:$LCP_DATABASE_ROOT_PATH/lcp.sqlite?cache=shared&mode=rwc

ENV LCP_BASE_URL=http://192.168.0.11:8989/lcpserver
ENV LCP_UPDATE_AUTH_USER=adm_username
ENV LCP_UPDATE_AUTH_PASS=adm_password
ENV LCP_DATABASE=sqlite3://file:$LCP_DATABASE_ROOT_PATH/lsd.sqlite?cache=shared&mode=rwc
ENV LCP_STORAGE_PATH=/lcp/files/storage

ENV FRONTEND_BASE_URL=http://192.168.0.11:8991/frontend
ENV FRONTEND_MANAGE=/frontend/manage
ENV FRONTEND_DATABASE=sqlite3://file:$LCP_DATABASE_ROOT_PATH/frontend.sqlite?cache=shared&mode=rwc

ENV FRONTEND_MASTER_PATH=/lcp/files/master
ENV FRONTEND_ENCRYPTED_PATH=/lcp/files/encrypted
ENV FRONTEND_PROVIDER_URI=https://jnanavahini.bhashini.ai

ENV READIUM_LCPSERVER_CONFIG=/config.yaml
ENV READIUM_LSDSERVER_CONFIG=/config.yaml
ENV READIUM_FRONTEND_CONFIG=/config.yaml

ENV PROFILE=$PROFILE
ENV SERVER_CMD=$SERVER_CMD

EXPOSE $PORT

ENV BASE_URL=https://jnanavahini.bhashini.ai/frontend/

#RUN ldd /usr/bin/lcpserver
#RUN ldd /usr/bin/lsdserver
#RUN ldd /usr/bin/frontend

RUN chmod +x /init.sh
CMD /init.sh $SERVER_CMD

