# syntax=docker/dockerfile:1.4

FROM alpine:3.18

ENV LANG en_US.utf8

ENV NFS_SERVER_DEBUG "1"
ENV NFS_SERVER_ALLOWED_CLIENTS "*"
RUN adduser nfsnobody -D
RUN <<EOF
    set -eu

    apk add --no-cache nfs-utils
EOF

EXPOSE 2049

COPY nfs-server /usr/local/bin
ENTRYPOINT ["/usr/local/bin/nfs-server"]
