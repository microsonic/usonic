# syntax=docker/dockerfile:experimental
ARG USONIC_MGMT_FRAMEWORK_IMAGE=usonic-mgmt-framework:latest

FROM ${USONIC_MGMT_FRAMEWORK_IMAGE} as mgmt_framework 

FROM debian:buster

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy make g++ graphviz autotools-dev autoconf doxygen libnl-3-dev libnl-genl-3-dev libnl-route-3-dev libnl-nf-3-dev libhiredis-dev perl libxml-simple-perl aspell swig libgtest-dev dh-exec debhelper libtool pkg-config python3-all python-all libpython3-dev libpython-dev quilt patchelf libboost-dev m4 libxml2-utils xsltproc python-lxml libexpat1-dev

RUN --mount=type=bind,source=/tmp,target=/tmp,from=mgmt_framework dpkg -i /tmp/*.deb
RUN --mount=type=bind,target=/root,rw cd /root && quilt push -a && make -C /root/make/mgmt-framework
