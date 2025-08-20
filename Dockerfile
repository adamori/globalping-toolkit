FROM alpine:3.22

LABEL org.opencontainers.image.title="Globalping Toolkit" \
      org.opencontainers.image.description="A toolkit image with globalping-cli, curl, and other utilities for running checks." \
      org.opencontainers.image.vendor="Adam Alidibirov" \
      org.opencontainers.image.authors="adam@alibiro.com" \
      org.opencontainers.image.source="https://github.com/adamori/globalping-toolkit" \
      org.opencontainers.image.version="1.5.0"

ARG GLOBALPING_VERSION=1.5.0
ARG TARGETARCH=amd64

RUN apk add --no-cache --virtual .build-deps wget zstd && \
    apk add --no-cache curl && \
    wget -qO- "https://github.com/jsdelivr/globalping-cli/releases/download/v${GLOBALPING_VERSION}/globalping_${GLOBALPING_VERSION}_linux_${TARGETARCH}.pkg.tar.zst" \
    | unzstd \
    | tar -xO usr/bin/globalping > /usr/local/bin/globalping && \
    chmod +x /usr/local/bin/globalping && \
    # Clean up build dependencies to reduce final image size.
    apk del .build-deps && \
    rm -rf /var/cache/apk/*

WORKDIR /app

CMD ["/bin/sh"]