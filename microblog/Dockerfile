FROM python:3.6

COPY . ~/microblog

RUN apt-get update && apt-get upgrade -y \
	&& pip3 install -r ~/microblog/requirements.txt \
	&& pip3 install gunicorn pymysql \
	&& rm -rf /var/lib/apt/lists/*

