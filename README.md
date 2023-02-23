# `libheif` builds in Docker

An example of building `libheif` in Docker with [rav1e](https://github.com/xiph/rav1e) and [dav1d](https://code.videolan.org/videolan/dav1d) support.

To pull this repo, use

```shell
git clone --recursive https://github.com/sunsided/libheif-docker-build.git
```

To build the Docker image, run

```shell
docker build --tag libheif .
```

Build output:

```
#32 0.595 Install the project...
#32 0.603 -- Install configuration: "Release"
#32 0.603 -- Installing: /usr/local/lib/libheif
#32 0.603 -- Installing: /usr/local/lib/pkgconfig/libheif.pc
#32 0.604 -- Installing: /usr/local/bin/heif-info
#32 0.605 -- Set runtime path of "/usr/local/bin/heif-info" to ""
#32 0.605 -- Installing: /usr/local/share/man/man1/heif-info.1
#32 0.605 -- Installing: /usr/local/bin/heif-convert
#32 0.606 -- Set runtime path of "/usr/local/bin/heif-convert" to ""
#32 0.607 -- Installing: /usr/local/share/man/man1/heif-convert.1
#32 0.607 -- Installing: /usr/local/bin/heif-enc
#32 0.608 -- Set runtime path of "/usr/local/bin/heif-enc" to ""
#32 0.608 -- Installing: /usr/local/share/man/man1/heif-enc.1
#32 0.608 -- Installing: /usr/local/bin/heif-thumbnailer
#32 0.609 -- Set runtime path of "/usr/local/bin/heif-thumbnailer" to ""
#32 0.609 -- Installing: /usr/local/share/man/man1/heif-thumbnailer.1
#32 0.610 -- Installing: /usr/local/lib/libheif.so.1.15.1
#32 0.611 -- Installing: /usr/local/lib/libheif.so.1
#32 0.611 -- Installing: /usr/local/lib/libheif.so
#32 0.611 -- Installing: /usr/local/include/libheif/heif.h
#32 0.612 -- Installing: /usr/local/include/libheif/heif_cxx.h
#32 0.612 -- Installing: /usr/local/include/libheif/heif_plugin.h
#32 0.612 -- Installing: /usr/local/include/libheif/heif_version.h
#32 0.612 -- Installing: /usr/local/lib/cmake/libheif/libheif-config.cmake
#32 0.613 -- Installing: /usr/local/lib/cmake/libheif/libheif-config-release.cmake
#32 0.613 -- Installing: /usr/local/lib/cmake/libheif/libheif-config-version.cmake
#32 0.614 -- Installing: /usr/local/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-heif.so
#32 0.614 -- Set runtime path of "/usr/local/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-heif.so" to ""
#32 0.614 -- Installing: /usr/local/share/thumbnailers/heif.thumbnailer
```