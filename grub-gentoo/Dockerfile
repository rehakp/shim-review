# name the portage image
FROM gentoo/portage:latest as portage

# based on stage3 image
FROM gentoo/stage3:latest

# copy the entire portage volume in
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo
COPY aos-overlay/ /usr/local/portage/
COPY etc/ /etc/
RUN ebuild /usr/local/portage/sys-boot/grub/grub-2.06-r84.ebuild manifest
RUN emerge grub
RUN grub-mkimage -O x86_64-efi -o "/grubx64.efi" -p "/EFI/AosHDD" --sbat="/etc/grub.d/sbat.csv" -v \
  all_video boot btrfs cat chain configfile echo efifwsetup ext2 fat font gettext \
  gfxmenu gfxterm gfxterm_background gzio halt help keystatus loadenv loopback \
  linux ls lsefi lsefimmap lsefisystab lssal lua memdisk minicmd normal ntfs \
  part_msdos part_gpt password_pbkdf2 play png probe reboot regexp search \
  search_fs_uuid search_fs_file search_label sleep test true video cryptodisk \
  gcry_arcfour gcry_blowfish gcry_camellia gcry_cast5 gcry_crc gcry_des gcry_dsa \
  gcry_idea gcry_md4 gcry_md5 gcry_rfc2268 gcry_rijndael gcry_rmd160 gcry_rsa \
  gcry_seed gcry_serpent gcry_sha1 gcry_sha256 gcry_sha512 gcry_tiger gcry_twofish \
  gcry_whirlpool luks lvm mdraid09 mdraid1x raid5rec raid6rec
