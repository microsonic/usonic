# syntax=docker/dockerfile:experimental
ARG USONIC_SWSS_COMMON_IMAGE=usonic-swss-common:latest
FROM ${USONIC_SWSS_COMMON_IMAGE} as swss_common

FROM debian:buster

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy make g++ graphviz autotools-dev autoconf doxygen libnl-3-dev libnl-genl-3-dev libnl-route-3-dev libnl-nf-3-dev libhiredis-dev perl libxml-simple-perl aspell swig libgtest-dev dh-exec debhelper libtool pkg-config python3-all python-all libpython3-dev libpython-dev quilt patchelf libboost-dev

RUN --mount=type=bind,source=/tmp,target=/tmp,from=swss_common dpkg -i /tmp/*.deb

RUN --mount=type=bind,source=sm/sonic-sairedis,target=/root/sm/sonic-sairedis,rw \
    --mount=type=bind,source=patches/sonic-sairedis,target=/root/patches \
    --mount=type=tmpfs,target=/root/.pc,rw \
    --mount=type=bind,source=make/sairedis,target=/root/make/sairedis \
    cd /root && quilt upgrade && quilt push -a && \
    make -C /root/make/sairedis
