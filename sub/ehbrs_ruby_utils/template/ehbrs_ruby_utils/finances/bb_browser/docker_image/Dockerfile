FROM debian:trixie-slim

ARG DEBIAN_MIRROR=http://ftp.br.debian.org
ARG WARSAW_URL=https://guardiao.itau.com.br/warsaw/warsaw_ubuntu.run
ARG WARSAW_SHA256=7b7e27961ccfb5ed9fb9d5eef00a44db81a6a0e778f96886464ffcacc28b9144

ENV DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  RESOLUTION=1366x768 \
  START_URL=https://www.bb.com.br \
  USER_GID=1000 \
  USER_UID=1000

RUN sed -i "s#http://deb.debian.org#$DEBIAN_MIRROR#" /etc/apt/sources.list.d/debian.sources \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    dbus-x11 \
    firefox-esr \
    firefox-esr-l10n-pt-br \
    fonts-dejavu \
    fonts-liberation \
    libarchive-tools \
    libdbus-1-3 \
    novnc \
    openbox \
    procps \
    python3 \
    tigervnc-standalone-server \
    tigervnc-tools \
    websockify \
    zenity \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSLo /tmp/warsaw.run "$WARSAW_URL" \
  && echo "$WARSAW_SHA256  /tmp/warsaw.run" | sha256sum -c - \
  && bsdtar -xf /tmp/warsaw.run -C /tmp --strip-components 1 'warsaw_setup/warsaw_*_amd64.deb' \
  && printf '#!/bin/sh\nexit 101\n' > /usr/sbin/policy-rc.d \
  && chmod +x /usr/sbin/policy-rc.d \
  && touch /tmp/EULA \
  && apt-get update \
  && apt-get install -y --no-install-recommends /tmp/warsaw_*_amd64.deb \
  && { pkill -f -x /usr/local/bin/warsaw/core || :; } \
  && rm -rf /tmp/warsaw* /usr/sbin/policy-rc.d /var/lib/apt/lists/*

COPY policies.json /usr/lib/firefox-esr/distribution/policies.json
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN useradd --create-home --shell /bin/bash browser \
  && install -d -m 1777 /tmp/.X11-unix

EXPOSE 6080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
