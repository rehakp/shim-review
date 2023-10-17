#!/bin/bash
set -e
SHIM_VERSION=15.7
logdir=$(realpath logs)
wget https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2 -O tmp/shim-${SHIM_VERSION}.tar.bz2 >"${logdir}/shim-build.log" 2>&1
tar -xjf tmp/shim-${SHIM_VERSION}.tar.bz2 --recursive-unlink -C tmp/
shimdir="tmp/shim-${SHIM_VERSION}/"
cp -a Adaptech.cer "${shimdir}"
cp -a sbat.adaptech.csv "${shimdir}data/"
patch -d "${shimdir}" -p1 <enable_nx.patch >>"${logdir}//shim-build.log"
pushd "${shimdir}"
make VENDOR_CERT_FILE=Adaptech.cer >>"${logdir}/shim-build.log" 2>&1
make DESTDIR="$PWD/bin" EFIDIR=AosHDD install >>"${logdir}/shim-build.log" 2>&1
cp -a shimx64.efi ..
popd
