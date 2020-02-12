# syntax=docker/dockerfile:experimental
FROM usonic

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
apt update && apt install -qy strace vim gdb procps
