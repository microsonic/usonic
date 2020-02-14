# syntax=docker/dockerfile:experimental
ARG USONIC_BUILDER_IMAGE
FROM ${USONIC_BUILDER_IMAGE} as builder

FROM debian:buster

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libnl-nf-3-200 libhiredis0.14

RUN --mount=type=bind,from=builder,source=/tmp,target=/tmp ls /tmp/*.deb | awk '$0 !~ /python/ { print $0 }' | xargs dpkg -i
RUN --mount=type=bind,from=builder,target=/tmp cp /tmp/usr/lib/x86_64-linux-gnu/libsaivs.so.0.0.0 /usr/lib/x86_64-linux-gnu/libsaivs.so.0.0.0
RUN cd /usr/lib/x86_64-linux-gnu/ && ln -s libsaivs.so libsai.so
