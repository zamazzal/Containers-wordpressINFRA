FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt-get install git inotify-tools -y

RUN git clone https://github.com/gitwatch/gitwatch.git && \
    cd gitwatch && install -b gitwatch.sh /usr/local/bin/gitwatch

COPY tools/setup_gitwatch.sh /tmp/setup_gitwatch.sh

RUN chmod +x /tmp/setup_gitwatch.sh

ENTRYPOINT [ "bash", "/tmp/setup_gitwatch.sh" ]
