# syntax=docker/dockerfile:experimental
FROM debian:buster as builder

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy make autotools-dev autoconf dh-exec debhelper libtool pkg-config m4 libxml2-utils xsltproc python-lxml libexpat1-dev python rsync wget default-jdk libxml2-dev git cmake gcc libpcre3-dev python-pip quilt python3 python3-pip devscripts doxygen libcmocka-dev

# remove libyang plugin library since debian package is broken
# TODO fix this
RUN --mount=type=tmpfs,target=/src cd /src && git clone https://github.com/CESNET/libyang.git && \
            sed -i -e '/usr\/lib\/\*\/libyang1/d' libyang/packages/debian.libyang.install && \
            cmake /src/libyang && make build-deb && cp -r debs/*.deb /tmp/ && make install && ldconfig

RUN --mount=type=tmpfs,target=/tmp cd /tmp && wget -O go.tar.gz https://golang.org/dl/go1.14.4.linux-amd64.tar.gz && tar -C /usr/local -xzf go.tar.gz

RUN pip install pyang pyyaml

RUN pip3 install jinja2

RUN --mount=type=bind,source=sm/sonic-mgmt-common,target=/root/sm/sonic-mgmt-common,rw \
    --mount=type=bind,source=sm/sonic-mgmt-framework,target=/root/sm/sonic-mgmt-framework,rw \
    --mount=type=bind,source=patches/mgmt,target=/root/patches \
    --mount=type=bind,source=make,target=/root/make \
    cd /root && quilt push -a && make -C /root/make/mgmt-framework
