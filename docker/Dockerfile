FROM ubuntu:20.04
    MAINTAINER Kritarth <me@kritarth.net>

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y curl wget screen nano file tar bzip2 gzip unzip \
    bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux \
    netcat lib32gcc1 lib32stdc++6 libsdl2-2.0-0:i386
RUN apt-get install -y dnsutils
COPY req.sh /
RUN /req.sh
COPY setup.sh /
COPY start.sh /
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
