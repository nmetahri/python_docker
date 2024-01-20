FROM python:3.13-rc-alpine

RUN apk update && apk add tk && apk add --no-cache --upgrade bash

RUN pip install --upgrade pip

RUN pip install \
    tk \
    && rm -rf /root/.cache/pip

RUN adduser -D user
USER user

WORKDIR /app
