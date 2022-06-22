FROM ubuntu:impish

LABEL maintainer="T145" \
      version="1.0.0" \
      description="An unstable image used to experiment with Docker."

# suppress language-related updates from apt-get to increase download speeds and configure debconf to be non-interactive
# https://github.com/phusion/baseimage-docker/issues/58#issuecomment-47995343
RUN echo 'Acquire::Languages "none";' >> /etc/apt/apt.conf.d/00aptitude \
      && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# set rust env path
ENV PATH=/root/.cargo/bin:$PATH

# directly from `.cargo/env`
# ENV PATH="$HOME/.cargo/bin:$PATH"

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run
# https://docs.docker.com/engine/reference/builder/#from
# use apt-get & apt-cache rather than apt: https://askubuntu.com/questions/990823/apt-gives-unstable-cli-interface-warning
RUN apt-get -y update \
      # install apt-utils early so debconf doesn't delay package configuration
      && apt-get -y install apt-utils \
      # upgrade with proper configurations
      && apt-get -y upgrade \
      && apt-get install -y --no-install-recommends build-essential curl pkg-config libssl-dev \
      && rm -rf /var/cache/debconf/* \
      && apt-get clean autoclean \
      && apt-get -y autoremove \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# https://github.com/lycheeverse/lychee#cargo=
# https://stackoverflow.com/a/57251636
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
      && cargo install lychee
