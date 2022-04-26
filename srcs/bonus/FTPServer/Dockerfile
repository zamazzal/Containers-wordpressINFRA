FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt install -y vsftpd -y

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY tools/setup_ftp.sh /tmp/setup_ftp.sh
RUN chmod +x /tmp/setup_ftp.sh

EXPOSE 21

ENTRYPOINT [ "bash", "/tmp/setup_ftp.sh" ]
