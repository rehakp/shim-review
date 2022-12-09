#!/bin/bash
set -e
rm -f build.log
SHIM_VERSION=15.7
wget https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2 -O shim-${SHIM_VERSION}.tar.bz2 >../build.log 2>&1
tar -xjf shim-${SHIM_VERSION}.tar.bz2 --recursive-unlink -C ..
pushd ../shim-${SHIM_VERSION}
cp -a ../shim-review/Adaptech.cer .
cp -a ../shim-review/sbat.adaptech.csv data/
patch -p1 <../shim-review/enable_nx.patch >>../build.log
make VENDOR_CERT_FILE=Adaptech.cer >>../build.log 2>&1
make DESTDIR="$PWD/bin" EFIDIR=aosHDD install >>../build.log 2>&1
cp -a shimx64.efi ..
popd
