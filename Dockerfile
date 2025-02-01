ARG BASE_IMAGE=""
ARG ARCH=""
FROM ${BASE_IMAGE} AS base

LABEL maintainer="Benoît Podwinski contact@benoitpodwinski.com"

ARG SERPOSCOPE_VER=3.5

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        wget https://www.serposcope.com/downloads/${SERPOSCOPE_VER}/serposcope_${SERPOSCOPE_VER}_amd64.deb -O serposcope.deb; \
    elif [ "$ARCH" = "arm64" ]; then \
        wget https://www.serposcope.com/downloads/${SERPOSCOPE_VER}/serposcope_${SERPOSCOPE_VER}_arm64.deb -O serposcope.deb; \
    elif [ "$ARCH" = "armhf" ]; then \
        wget https://www.serposcope.com/downloads/${SERPOSCOPE_VER}/serposcope_${SERPOSCOPE_VER}_armhf.deb -O serposcope.deb; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    dpkg -i serposcope.deb && rm serposcope.deb || true

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
