FROM ubuntu:20.04

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && apt-get install -y make curl git python build-essential golang bsdmainutils

WORKDIR /lcp
COPY . /lcp/.

RUN make lcpencrypt && ls -als -R /lcp/build/bin

