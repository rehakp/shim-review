Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files - enable_nx.patch
 - [x] any extra patches to grub via your own git tree or as files - https://github.com/rehakp/shim-review/blob/adaptech-shim-x86_64-20231121/grub-gentoo
 - [x] build logs - in the `logs/` subdirectory
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/rehakp/shim-review/tree/adaptech-shim-x86_64-20231121`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
170bb326192ac637137df71a0fa1916e0a243308cb0bdfc66ff285580282bd4c

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/248
