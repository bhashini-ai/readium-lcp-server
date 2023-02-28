#! /bin/bash

docker stop lcpserver
docker rm lcpserver
docker run -d --restart always --publish 8989:8989 --volume /home/lcp:/lcp --name lcpserver lcpserver

# docker run --rm -it --entrypoint sh lcpserver #For debugging

docker stop lsdserver
docker rm lsdserver
docker run -d --restart always --publish 8990:8990 --volume /home/lcp:/lcp --name lsdserver lsdserver

docker stop frontendtestserver
docker rm frontendtestserver
docker run -d --restart always --publish 8991:8991 --volume /home/lcp:/lcp --name frontendtestserver frontendtestserver
