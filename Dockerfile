FROM ubuntu:focal

COPY . /shim-review
RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y devscripts git-buildpackage software-properties-common && \
    apt build-dep -y shim

WORKDIR /shim-review
RUN wget https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2 && \
tar -xjf shim-15.4.tar.bz2 -C / && \
cp -a Adaptech.cer /shim-15.4 && \
cp -a adaptech-shim-sbat.csv /shim-15.4/data/sbat.csv && \
./make_shim.sh
WORKDIR /

# FIXME: This only works on x86-64 efi binary
RUN hexdump -Cv /shim-review/shimx64.efi > orig && \
    hexdump -Cv /shim-15.4/shimx64.efi > build && \
    diff -u orig build
RUN sha256sum /shim-review/shimx64.efi && \
sha256sum /shim-15.4/shimx64.efi
