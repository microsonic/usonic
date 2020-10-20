# syntax=docker/dockerfile:experimental
ARG USONIC_SWSS_COMMON_IMAGE=usonic-swss-common:latest
ARG USONIC_SAIREDIS_IMAGE=usonic-sairedis:latest
ARG USONIC_SWSS_IMAGE=usonic-swss:latest

FROM ${USONIC_SWSS_COMMON_IMAGE} as swss_common
FROM ${USONIC_SAIREDIS_IMAGE} as sairedis
FROM ${USONIC_SWSS_IMAGE} as swss
FROM debian:buster

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy libnl-3-200 libnl-genl-3-200 libnl-route-3-200 libnl-nf-3-200 libhiredis0.14 python libpython-dev

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy strace vim gdb procps redis-server syslog-ng tcpdump

RUN --mount=type=bind,from=swss_common,source=/tmp,target=/tmp dpkg -i /tmp/*.deb

RUN --mount=type=bind,from=sairedis,source=/tmp,target=/tmp dpkg -i /tmp/*.deb
RUN --mount=type=bind,from=sairedis,target=/tmp cp /tmp/usr/lib/x86_64-linux-gnu/libsaivs.so.0.0.0 /usr/lib/x86_64-linux-gnu/libsaivs.so.0.0.0
RUN cd /usr/lib/x86_64-linux-gnu/ && ln -s libsaivs.so libsai.so

RUN --mount=type=bind,from=swss,source=/tmp,target=/tmp dpkg -i /tmp/*.deb
