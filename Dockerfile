FROM ubuntu:jammy

COPY . /shim-review
RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y devscripts git-buildpackage software-properties-common && \
    apt build-dep -y shim

WORKDIR /shim-review
RUN ./make_shim.sh

RUN hexdump -Cv shimx64.efi > orig && \
    hexdump -Cv tmp/shimx64.efi > build && \
    diff -u orig build
RUN sha256sum shimx64.efi && \
    sha256sum tmp/shimx64.efi
