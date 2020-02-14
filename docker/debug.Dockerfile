# syntax=docker/dockerfile:experimental
ARG USONIC_IMAGE
FROM ${USONIC_IMAGE}

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy strace vim gdb procps
