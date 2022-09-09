#!/bin/bash
set -e
rm -f build.log
SHIM_VERSION=15.6
wget https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2 -O shim-${SHIM_VERSION}.tar.bz2
tar -xjf shim-${SHIM_VERSION}.tar.bz2 -C ..
pushd ../shim-${SHIM_VERSION}
cp -a ../shim-review/Adaptech.cer .
cp -a ../shim-review/sbat.adaptech.csv data/
make VENDOR_CERT_FILE=Adaptech.cer >>../build.log 2>&1
make DESTDIR="$PWD/bin" EFIDIR=aosHDD install >>../build.log 2>&1
cp -a shimx64.efi ..
popd
