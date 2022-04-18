FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install libfcgi0ldbl -y
RUN apt-get install mariadb-client -y

ENTRYPOINT [ "tail", "-f", "/dev/null" ]