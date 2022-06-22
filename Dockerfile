FROM rust:latest

LABEL maintainer="T145" \
      version="1.0.0" \
      description="An unstable image used to experiment with Docker."

RUN cargo install lychee
