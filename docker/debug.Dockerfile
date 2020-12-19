# syntax=docker/dockerfile:experimental
ARG USONIC_SWSS_COMMON_IMAGE=usonic-swss-common:latest
ARG USONIC_SAIREDIS_IMAGE=usonic-sairedis:latest
ARG USONIC_SWSS_IMAGE=usonic-swss:latest
ARG USONIC_RUN_IMAGE=usonic:latest

FROM ${USONIC_SWSS_COMMON_IMAGE} as swss_common
FROM ${USONIC_SAIREDIS_IMAGE} as sairedis
FROM ${USONIC_SWSS_IMAGE} as swss

FROM ${USONIC_RUN_IMAGE}

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy --no-install-recommends libpython-dev strace vim gdb procps redis-server syslog-ng tcpdump

RUN --mount=type=bind,from=swss_common,source=/tmp,target=/tmp dpkg -i /tmp/*.deb

RUN --mount=type=bind,from=sairedis,source=/tmp,target=/tmp dpkg -i /tmp/*.deb

RUN --mount=type=bind,from=swss,source=/tmp,target=/tmp dpkg -i /tmp/*.deb
