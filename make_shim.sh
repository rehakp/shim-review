#!/bin/bash
set -e
SHIM_VERSION=15.7
wget https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2 -O shim-${SHIM_VERSION}.tar.bz2 >../build.log 2>&1
tar -xjf shim-${SHIM_VERSION}.tar.bz2 --recursive-unlink -C ..
shimdir="../shim-${SHIM_VERSION}/"
cp -a Adaptech.cer "${shimdir}"
cp -a sbat.adaptech.csv "${shimdir}data/"
patch -d "${shimdir}" -p1 <enable_nx.patch >>../build.log
pushd "${shimdir}"
make VENDOR_CERT_FILE=Adaptech.cer >>../build.log 2>&1
make DESTDIR="$PWD/bin" EFIDIR=AosHDD install >>../build.log 2>&1
cp -a shimx64.efi ..
popd
