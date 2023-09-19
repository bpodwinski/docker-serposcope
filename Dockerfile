FROM ubuntu:latest
LABEL maintainer="Benoît Podwinski contact@benoitpodwinski.com"

ARG SERPOSCOPE_VER=3.3

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://www.serposcope.com/downloads/${SERPOSCOPE_VER}/serposcope_${SERPOSCOPE_VER}_amd64.deb -O serposcope.deb && \
    dpkg -i serposcope.deb && \
    rm serposcope.deb

COPY application.conf /usr/share/serposcope
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /usr/share/serposcope/

RUN mkdir -p ./db && \
    chown -R serposcope:serposcope ./db

VOLUME ["/usr/share/serposcope/db"]
EXPOSE 6333
USER root

ENTRYPOINT ["/entrypoint.sh"]
