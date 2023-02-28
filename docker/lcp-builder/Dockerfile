FROM golang:alpine
RUN apk add build-base

WORKDIR /lcp
COPY . /lcp/.

ARG BUILD_PROD=false
ARG LIBUSERKEY_PATH=/docker/dummy
ARG USERKEYH_PATH=/docker/dummy
ARG USERKEYGO_PATH=/docker/dummy

COPY $LIBUSERKEY_PATH $LIBUSERKEY_PATH
COPY $USERKEYH_PATH $USERKEYH_PATH
COPY $USERKEYGO_PATH $USERKEYGO_PATH

RUN make BUILD_PROD=${BUILD_PROD} LIBUSERKEY_PATH=${LIBUSERKEY_PATH} USERKEYH_PATH=${USERKEYH_PATH} USERKEYGO_PATH=${USERKEYGO_PATH} lcpserver && ls -als -R /lcp/build/bin

RUN make lsdserver && ls -als -R /lcp/build/bin

RUN make frontend && ls -als -R /lcp/build/bin

RUN make lcpencrypt && ls -als -R /lcp/build/bin
