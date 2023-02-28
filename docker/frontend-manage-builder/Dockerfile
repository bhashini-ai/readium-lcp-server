FROM ubuntu:20.04

WORKDIR /lcp
COPY . /lcp/.

RUN apt-get update \
    && apt-get install -y make curl git \
    && curl -O https://nodejs.org/dist/v6.9.2/node-v6.9.2-linux-x64.tar.gz \
    && tar -xzf node-v6.9.2-linux-x64.tar.gz

RUN PATH=/lcp/node-v6.9.2-linux-x64/bin:$PATH make "frontend/manage"

