FROM python:3.8.3-alpine3.12

ARG APP_NAME=carteiropy
ARG DEFAULT_USER=python

# Default System configs
RUN apk add --no-cache gcc \
    && addgroup --gid 1000 -S ${DEFAULT_USER} \
    && adduser --uid 1000 -D -G ${DEFAULT_USER} -g "${DEFAULT_USER}" ${DEFAULT_USER} ${DEFAULT_USER} \
    && ln -sT /usr/local/bin/python /bin/python3 \
    && chmod +x /bin/python3

# APP Install Requirements

COPY requirements.txt /tmp
COPY ./code /usr/local/scr/${APP_NAME}

RUN pip install -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

# App Configurations

 USER 1000:1000
 WORKDIR /usr/local/scr/${APP_NAME}