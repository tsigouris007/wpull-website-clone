FROM python:3.5.10-alpine3.12

ENV USER_AGENT "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36"
ENV WAIT "1"
ENV WAITRETRY "300"
ENV LEVEL "1"
ENV TIMEOUT "120"
ENV TRIES "3"
ENV WEBSITE ""
ENV SRV_PORT ""

RUN apk update
RUN apk add bash
RUN python -m pip install --upgrade pip
RUN pip3 install tornado==4.5.3
RUN pip3 install html5lib==0.9999
RUN pip3 install wpull

RUN mkdir /app
WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT [ "bash", "/app/entrypoint.sh" ]
