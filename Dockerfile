FROM rust:latest AS rust

# https://vfoley.xyz/rust-compilation-tip/
ENV RUSTFLAGS="-C target-cpu=native" 

RUN cargo install lychee

# production image
FROM ubuntu:impish

LABEL maintainer="T145" \
      version="1.0.0" \
      description="An unstable image used to experiment with Docker."

COPY --from=rust /usr/local/cargo/ /usr/local/
# COPY --from=rust /usr/local/rustup/ /usr/local/

ENV PATH=/usr/local/cargo/bin:$PATH

# Copying from the latest Docker image should mean `rustup` doesn't need to be copied and executed.
# RUN rustup update
