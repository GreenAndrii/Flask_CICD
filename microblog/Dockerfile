FROM python:3.6-alpine

RUN adduser -D microblog

WORKDIR /home/microblog

COPY requirements.txt requirements.txt
RUN python -m venv venv \
	&& pip install --upgrade pip \
	&& venv/bin/pip install -r requirements.txt \
	&& venv/bin/pip install gunicorn pymysql \
	&& apk add --no-cache bash

COPY app app
COPY migrations migrations
COPY microblog.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP microblog.py

RUN chown -R microblog:microblog ./
USER microblog

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]