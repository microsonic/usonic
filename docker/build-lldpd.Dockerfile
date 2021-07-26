# syntax=docker/dockerfile:experimental
ARG USONIC_SWSS_COMMON_IMAGE=usonic-swss-common:latest

FROM ${USONIC_SWSS_COMMON_IMAGE} as swss_common

FROM debian:buster

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy make g++ graphviz autotools-dev autoconf doxygen stgit libnl-genl-3-dev libnl-nf-3-dev libhiredis-dev perl libxml-simple-perl aspell swig libgtest-dev dh-exec debhelper libtool python3-all python-all libpython3-dev libpython-dev quilt patchelf libboost-dev libbsd-dev pkg-config check libsnmp-dev libpci-dev libxml2-dev libevent-dev libreadline-dev libcap-dev libjansson-dev dh-systemd python3 python python-pip

RUN --mount=type=bind,source=sm/sonic-py-swsssdk,target=/src,rw pip install /src
RUN --mount=type=bind,source=sm/sonic-dbsyncd,target=/src,rw pip install /src
RUN --mount=type=bind,source=/tmp,target=/tmp,from=swss_common dpkg -i /tmp/*.deb
RUN --mount=type=bind,target=/root,rw cd /root && quilt push -a && make -C /root/make/lldpd
