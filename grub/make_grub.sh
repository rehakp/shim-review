#!/bin/bash
set -e
GRUB_VERSION=2.06
grubdir="../grub-${GRUB_VERSION}/"
export extrasdir="$PWD/grub-extras"
rm -rf "$grubdir"
wget https://ftp.gnu.org/gnu/grub/grub-${GRUB_VERSION}.tar.gz -O grub-${GRUB_VERSION}.tar.gz >>../build.log 2>&1
tar -xzf grub-${GRUB_VERSION}.tar.gz -C ..
patchdir="$PWD/patches"
if [ ! -d "$patchdir" ]; then
  echo "Error: directory \"$patchdir\" not found"
  return 1
fi
PatchFiles=()
pushd "$patchdir"
while read f; do
  [ "${f:0:1}" = ";" ] && continue
  if [ -d "$f" ]; then
    PatchFiles+=($f/*)
  else
    PatchFiles+=("$f")
  fi
done < "patches.lst"
popd
pushd "$grubdir"
for f in "${PatchFiles[@]}"; do
  echo "$f"
  patch -p1 --no-backup-if-mismatch < "$patchdir/$f"
done | tee -a ../build.log
GRUB_MODULES="
		all_video
		boot
		btrfs
		cat
		chain
		configfile
		echo
		efifwsetup
		ext2
		fat
		font
		gettext
		gfxmenu
		gfxterm
		gfxterm_background
		gzio
		halt
		help
		keystatus
		loadenv
		loopback
		linux
		ls
		lsefi
		lsefimmap
		lsefisystab
		lssal
		lua
		memdisk
		minicmd
		normal
		ntfs
		part_msdos
		part_gpt
		password_pbkdf2
		play
		png
		probe
		reboot
		regexp
		search
		search_fs_uuid
		search_fs_file
		search_label
		sleep
		test
		true
		video
		cryptodisk
		gcry_arcfour
		gcry_blowfish
		gcry_camellia
		gcry_cast5
		gcry_crc
		gcry_des
		gcry_dsa
		gcry_idea
		gcry_md4
		gcry_md5
		gcry_rfc2268
		gcry_rijndael
		gcry_rmd160
		gcry_rsa
		gcry_seed
		gcry_serpent
		gcry_sha1
		gcry_sha256
		gcry_sha512
		gcry_tiger
		gcry_twofish
		gcry_whirlpool
		luks
		lvm
		mdraid09
		mdraid1x
		raid5rec
		raid6rec
	     "
  (
    ./autogen.sh
    GRUB_BIN=$PWD/bin
    ./configure --prefix="${GRUB_BIN}" --with-platform=efi
    make -j$(nproc)
    make -j$(nproc) install
    "${GRUB_BIN}/bin/grub-mkimage" -O x86_64-efi -o "../grubx64.efi" -d "${GRUB_BIN}/lib/grub/x86_64-efi" -p "/EFI/AosHDD" --sbat="${GRUB_BIN}/etc/grub.d/sbat.csv" ${GRUB_MODULES}
  ) 2> >(tee -a ../build.log >&2)
popd
