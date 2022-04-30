FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update
RUN apt-get install -y build-essential autotools-dev pkg-config m4 libtool automake autoconf
RUN apt-get install -y libaom-dev libde265-dev libx265-dev libturbojpeg0-dev libpng-dev

WORKDIR /libheif
ADD ./libheif .
ADD ./dav1d /libheif/third-party/
ADD ./rav1e /libheif/third-party/
RUN cd /libheif

RUN ./autogen.sh
RUN ./configure

RUN make