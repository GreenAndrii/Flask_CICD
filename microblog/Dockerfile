FROM python:3.6

COPY requirements.txt /tmp

RUN apt-get update && apt-get upgrade -y \
    && pip3 install -r /tmp/requirements.txt \
    && pip3 install gunicorn pymysql \
    && rm -rf /var/lib/apt/lists/*
 
