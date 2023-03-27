#! /bin/bash

docker stop lcpserver
docker rm lcpserver
docker run -d --restart always --publish $LCP_PORT:$LCP_PORT --volume $LCP_VOLUME_DIR:/lcp -e AUTH_FILE=/lcp/htpasswd -e CERTIFICATE_PATH=$CERTS_DIR/fullchain.pem -e PRIVATE_KEY=$CERTS_DIR/privkey.pem -e LCP_STORAGE_PATH=/lcp/files/storage -e LCP_HOST -e LCP_PORT -e LSD_HOST -e LSD_PORT -e LCP_BASE_URL -e LCP_UPDATE_AUTH_USER -e LCP_UPDATE_AUTH_PASS -e LSD_BASE_URL -e LSD_NOTIFY_AUTH_USER -e LSD_NOTIFY_AUTH_PASS -e PUBLIC_URL --name lcpserver lcpserver

docker stop lsdserver
docker rm lsdserver
docker run -d --restart always --publish $LSD_PORT:$LSD_PORT --volume $LCP_VOLUME_DIR:/lcp -e AUTH_FILE=/lcp/htpasswd -e CERTIFICATE_PATH=$CERTS_DIR/fullchain.pem -e PRIVATE_KEY=$CERTS_DIR/privkey.pem -e LCP_STORAGE_PATH=/lcp/files/storage -e LCP_HOST -e LCP_PORT -e LSD_HOST -e LSD_PORT -e LCP_BASE_URL -e LCP_UPDATE_AUTH_USER -e LCP_UPDATE_AUTH_PASS -e LSD_BASE_URL -e LSD_NOTIFY_AUTH_USER -e LSD_NOTIFY_AUTH_PASS -e PUBLIC_URL --name lsdserver lsdserver
