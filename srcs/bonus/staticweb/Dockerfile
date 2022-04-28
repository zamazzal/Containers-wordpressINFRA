FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools python3-venv -y

RUN pip3 install wheel uwsgi flask

RUN mkdir -p /home/staticweb

WORKDIR /home/staticweb

COPY config/index.py /home/staticweb/index.py
COPY config/static /home/staticweb/static

ENV FLASK_APP=/home/staticweb/index.py
ENV FLASK_ENV=development

RUN adduser flaskuser --disabled-password

EXPOSE 3000

ENTRYPOINT [ "uwsgi", "--http-socket=0.0.0.0:3000", "--wsgi-file=/home/staticweb/index.py", "--callable=app", "--processes=4", "--threads=2", "--uid=flaskuser"]