FROM python:3.13-rc-alpine

RUN apk update && apk add tk

RUN pip install --upgrade pip

RUN pip install \
    tk \
    && rm -rf /root/.cache/pip

RUN adduser -D myuser
USER myuser

WORKDIR /app
