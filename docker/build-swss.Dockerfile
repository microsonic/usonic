# syntax=docker/dockerfile:experimental
ARG USONIC_SWSS_COMMON_IMAGE=usonic-swss-common:latest
ARG USONIC_SAIREDIS_IMAGE=usonic-sairedis:latest
ARG USONIC_LIBTEAM_IMAGE=usonic-libteam:latest

FROM ${USONIC_SWSS_COMMON_IMAGE} as swss_common
FROM ${USONIC_SAIREDIS_IMAGE} as sairedis
FROM ${USONIC_LIBTEAM_IMAGE} as libteam

FROM debian:buster

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy --no-install-recommends make g++ graphviz autotools-dev autoconf doxygen libnl-3-dev libnl-genl-3-dev libnl-route-3-dev libnl-nf-3-dev libhiredis-dev perl libxml-simple-perl aspell swig libgtest-dev dh-exec debhelper libtool pkg-config python3-all python-all libpython3-dev libpython-dev quilt patchelf libboost-dev libteam-dev build-essential libdaemon-dev libdbus-1-dev libjansson-dev libnl-3-dev libnl-cli-3-dev libnl-genl-3-dev libnl-route-3-dev pkg-config

RUN --mount=type=bind,source=/tmp,target=/tmp,from=swss_common dpkg -i /tmp/*.deb
RUN --mount=type=bind,source=/tmp,target=/tmp,from=sairedis dpkg -i /tmp/*.deb
RUN --mount=type=bind,source=/tmp,target=/tmp,from=libteam dpkg -i /tmp/*.deb

RUN --mount=type=bind,source=sm/sonic-swss,target=/root/sm/sonic-swss,rw \
    --mount=type=bind,source=patches/sonic-swss,target=/root/patches \
    --mount=type=tmpfs,target=/root/.pc,rw \
    --mount=type=bind,source=make/swss,target=/root/make/swss\
    cd /root && quilt upgrade && quilt push -a && \
    make -C /root/make/swss
