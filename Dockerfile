FROM ubuntu:22.04 AS build-base

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update
RUN apt-get install -y build-essential autotools-dev pkg-config m4 libtool automake autoconf gettext meson ninja-build nasm git cmake
RUN apt-get install -y libaom-dev libde265-dev libx265-dev libturbojpeg0-dev libpng-dev libgdk-pixbuf2.0-dev

# Build dav1d
FROM build-base AS dav1d-build
WORKDIR /dav1d
ADD dav1d .
RUN meson build --default-library=static --buildtype release --prefix "$(pwd)/dist" $@
RUN ninja -C build
RUN ninja -C build install

# Build rav1e
FROM rust:1.67-bullseye AS rav1e-build
RUN apt-get update
RUN apt-get install -y nasm
RUN cargo install cargo-c
WORKDIR /rav1e
ADD rav1e .
RUN cargo cinstall --crt-static --release --prefix="$(pwd)/dist" --library-type=staticlib

# Build libheif
FROM build-base AS build-libheif
WORKDIR /libheif
ADD libheif .
COPY --from=dav1d-build /dav1d ./third-party/dav1d
COPY --from=rav1e-build /rav1e ./third-party/rav1e
ENV PKG_CONFIG_PATH /libheif/third-party/rav1e/dist/lib/pkgconfig:/libheif/third-party/dav1d/dist/lib/x86_64-linux-gnu/pkgconfig:$PKG_CONFIG_PATH
RUN ldconfig
WORKDIR /libheif/build
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN make
RUN make install