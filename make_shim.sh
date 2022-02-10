#!/bin/bash
cd shim
# test if files of the given mask exist
if [[ -n $(shopt -s nullglob; echo *.o) ]]; then
  rm -rf bin
  mkdir bin
  make clean >../build.log 2>&1
fi \
&& make VENDOR_CERT_FILE=Adaptech.cer >>../build.log 2>&1 \
&& make DESTDIR="$PWD/bin" EFIDIR=aosHDD install >>../build.log 2>&1
