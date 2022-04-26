FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt install -y redis-server

COPY tools/setup_redis.sh /tmp/setup_redis.sh
RUN chmod +x /tmp/setup_redis.sh

EXPOSE 6379

ENTRYPOINT [ "bash", "/tmp/setup_redis.sh" ]
