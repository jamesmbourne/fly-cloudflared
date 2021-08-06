FROM alpine

ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz
ENV S6_OVERLAY_RELEASE=${S6_OVERLAY_RELEASE}

RUN apk --update add --no-cache wget jo bash

# Only used as the demo app - you can remove this
RUN apk --update add --no-cache nginx

RUN wget -q https://github.com/cloudflare/cloudflared/releases/download/2021.8.1/cloudflared-linux-amd64 && \
    chmod +x cloudflared-linux-amd64 && \
    mkdir -p /bin && \
    mv cloudflared-linux-amd64 /bin/cloudflared

RUN wget ${S6_OVERLAY_RELEASE} -O /tmp/s6overlay.tar.gz

RUN tar xzf /tmp/s6overlay.tar.gz -C /

COPY ./docker/services.d /etc/services.d/
COPY ./docker/cont-init.d /etc/cont-init.d/
COPY ./docker/bin/wait-for-it /bin/wait-for-it

ENTRYPOINT [ "/init" ]
