FROM ubuntu:latest
LABEL maintainer="Benoît Podwinski contact@benoitpodwinski.com"

ARG SERPOSCOPE_VER=3.5

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://www.serposcope.com/downloads/${SERPOSCOPE_VER}/serposcope_${SERPOSCOPE_VER}_amd64.deb -O serposcope.deb && \
    dpkg -i serposcope.deb && \
    rm serposcope.deb

COPY application.conf /usr/share/serposcope/
COPY entrypoint.sh /entrypoint.sh

RUN groupadd -r serposcope && \
    useradd -r -g serposcope serposcope && \
    chmod +x /entrypoint.sh

WORKDIR /usr/share/serposcope/

RUN mkdir -p ./db && chown -R serposcope:serposcope ./db

VOLUME ["/usr/share/serposcope/db"]
EXPOSE 6333
USER root

ENTRYPOINT ["/entrypoint.sh"]
