# Base image with or without GPU support.
FROM nvidia/cuda:13.0.2-cudnn-devel-ubuntu24.04
#FROM ubuntu:24.04

# Note: this variable comes from the compose file, but it has to
# be declared before use.
ARG TIME_ZONE

# Install required system packages (and tzdata for timezone).
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        tzdata \
        bash \
        git \
        ca-certificates build-essential cmake && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    rm -rf /var/lib/apt/lists/*

# Mitsuba build dependencies.
# (https://mitsuba.readthedocs.io/en/latest/src/developer_guide/compiling.html#linux)
RUN apt-get update && \
    apt-get install -y \
        clang-18 \
        libc++-18-dev \
        libc++abi-18-dev \
        cmake \
        ccache \
        ninja-build \
        libpng-dev \
        libjpeg-dev \
        libpython3-dev && \
        # python3-setuptools &&\
    rm -rf /var/lib/apt/lists/*

# Install UV.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /workspace/
