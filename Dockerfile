FROM ubuntu:focal

COPY . /shim-review
RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y devscripts git-buildpackage software-properties-common && \
    apt build-dep -y shim

WORKDIR /shim-review
RUN ./make_shim.sh
WORKDIR /

# FIXME: This only works on x86-64 efi binary
RUN hexdump -Cv /shim-review/shimx64.efi > orig && \
    hexdump -Cv shimx64.efi > build && \
    diff -u orig build
RUN sha256sum /shim-review/shimx64.efi && \
sha256sum shimx64.efi
