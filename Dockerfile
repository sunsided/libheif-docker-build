FROM ubuntu:20.04 AS build-base

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update
RUN apt-get install -y build-essential autotools-dev pkg-config m4 libtool automake autoconf gettext meson ninja-build nasm git
RUN apt-get install -y libaom-dev libde265-dev libx265-dev libturbojpeg0-dev libpng-dev libgdk-pixbuf2.0-dev

# Build dav1d
FROM build-base AS dav1d-build
RUN git clone --depth 1 --branch 1.0.0 https://code.videolan.org/videolan/dav1d.git /dav1d
WORKDIR /dav1d
RUN meson build --default-library=static --buildtype release --prefix "$(pwd)/dist" $@
RUN ninja -C build
RUN ninja -C build install

# Build rav1e
FROM rust:1.60-bullseye AS rav1e-build
RUN apt-get update
RUN apt-get install -y nasm
RUN cargo install cargo-c
RUN git clone --depth 1 --branch 0.5 https://github.com/xiph/rav1e.git /rav1e
WORKDIR /rav1e
RUN cargo cinstall --crt-static --release --prefix="$(pwd)/dist" --library-type=staticlib

# Build libheif
FROM build-base AS build-libheif
WORKDIR /libheif
ADD libheif .
COPY --from=dav1d-build /dav1d ./third-party/dav1d
COPY --from=rav1e-build /rav1e ./third-party/rav1e
ENV PKG_CONFIG_PATH /libheif/third-party/rav1e/dist/lib/pkgconfig:/libheif/third-party/dav1d/dist/lib/x86_64-linux-gnu/pkgconfig
RUN ldconfig
RUN ./autogen.sh
RUN ./configure

RUN make
RUN make install