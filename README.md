This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
We are Adaptech s.r.o. (https://www.adaptech.cz), distributor of various electronic, often computer-based devices, that aid mainly visually impaired in their way for independence in their life. Our company is small, employing no more than 20 employees. Almost all employees including me are blind or visually impaired. We, however, do have our development department and invest much money and effort into our own development.

*******************************************************************************
### What product or service is this for?
*******************************************************************************
AOS is a self-voiced and magnified application mainly for blind and visually impaired people whose purpose is to create backup / restore the operating system.

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
For the AOS system to be loadable even before Windows boots, we have been utilizing the GRUB2 bootloader, and to satisfy requirements of modern architectures with Secure Boot enabled, we have found Shim as the loader of choice for us. As almost none of our customers are technically skilled persons, everything has to be designed this way. Thus we are not distributing MOK Manager and the Fallback to prevent MOK management because we don't want our customers to mess with their preconfigured system and we want to make things as simple as they can be, i.e. if the Shim does not verify our kernel signed by our EV key, it does not bother the user with MOKs, allowing us to get clear feedback on what has happened and to take the computer for service. Considering AOS Manager, SHIM's role is even more evident as it has to be part of AOS installations performed by staff of commercial subjects, thus our Shim gets to the subject's customers.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
Because Shim signs GRUB and we have specific requirements on how the GRUB should look like and behave for our blind and visually impaired customers (i.e. to allow capturing certain keyboard keys even while playing a tune, creating menu items enhanced by help messages etc.) We supply a patch set that can be reviewed. We simply cannot adopt anybody else's GRUB.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Petr Řehák
- Position: developer
- Email address: rehak@adaptech.cz
- PGP key fingerprint:
      C9FA 48C0 1DCD 9FF3 9CA5  78A0 350E 19BE 2CFB 165F

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: František Žána
- Position: executive director
- Email address: zana@adaptech.cz
- PGP key fingerprint:
      11D0 20A6 0F25 0920 40A3  0116 C335 B2ED BC54 0D91

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.7 shim release tar?
Please create your shim binaries starting with the 15.7 shim release tar file: https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.7 and contains the appropriate gnu-efi source.

*******************************************************************************
The binary has been built from the 15.7 tarball.

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
https://github.com/rehakp/shim-review/tree/adaptech-shim-x86_64-20221209

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
The enable_nx patch (available in this repository) enables the NX DLL Characteristic for the SHIM binary.

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
Upstream GRUB2 shim_lock verifier

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list, the March 2021 grub2 CVE list, the June 7th 2022 grub2 CVE list, or the November 15th 2022 list, have fixes for all these CVEs been applied?

* CVE-2020-14372
* CVE-2020-25632
* CVE-2020-25647
* CVE-2020-27749
* CVE-2020-27779
* CVE-2021-20225
* CVE-2021-20233
* CVE-2020-10713
* CVE-2020-14308
* CVE-2020-14309
* CVE-2020-14310
* CVE-2020-14311
* CVE-2020-15705
* CVE-2021-3418 (if you are shipping the shim_lock module)

* CVE-2021-3695
* CVE-2021-3696
* CVE-2021-3697
* CVE-2022-28733
* CVE-2022-28734
* CVE-2022-28735
* CVE-2022-28736
* CVE-2022-28737

* CVE-2022-2601
* CVE-2022-3775
*******************************************************************************
Yes, we are using GRUB 2.06 with 43 security fixes delivered by Gentoo.

*******************************************************************************
### If these fixes have been applied, have you set the global SBAT generation on your GRUB binary to 3?
*******************************************************************************
Yes.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
We haven't shipped Shim along with GRUB2 yet. Our GRUB does not allow for booting anything except the Linux kernel included in the distro and the Windows Boot Loader.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
Our gentoo kernel 5.15.82 meets this requirement.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
No.

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We don't use that.

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
This certificate has not been used for this purpose yet.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
- Ubuntu 22.04
- gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
- GNU ld (GNU Binutils for Ubuntu) 2.38 
- see our dockerfile

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
The file build.log contains the whole log from `make clean` to `make install`.
The file docker.log contains docker output, i.e. from installing a toolchain to building the Shim and comparing SHA256 checksums.

*******************************************************************************
### What changes were made since your SHIM was last signed?
*******************************************************************************
There were no changes as we haven't had any signed Shim yet.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
4a1fb79dc5bbefcb5e93e9c9fe321f44117ed33f4cebdf768d527b5782046a92

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
Our keys are on a HSM from our Authenticode certificate authority, exclusively in our hands, in the building where our company is based. This HSM disallows, from its nature, to export private keys.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
Yes.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
*******************************************************************************
`Shim SBAT:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,3,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.adaptech,3,Adaptech s.r.o.,shim,15.7,info@adaptech.cz

GRUB SBAT:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.adaptech,3,Adaptech s.r.o.,grub,2.06-r82,info@adaptech.cz`

*******************************************************************************
### Which modules are built into your signed grub image?
*******************************************************************************
all_video boot btrfs cat chain configfile echo efifwsetup ext2 fat font gettext gfxmenu gfxterm gfxterm_background gzio halt help keystatus loadenv loopback linux ls lsefi lsefimmap lsefisystab lssal lua memdisk minicmd normal ntfs part_msdos part_gpt password_pbkdf2 play png probe reboot regexp search search_fs_uuid search_fs_file search_label sleep test true video cryptodisk gcry_arcfour gcry_blowfish gcry_camellia gcry_cast5 gcry_crc gcry_des gcry_dsa gcry_idea gcry_md4 gcry_md5 gcry_rfc2268 gcry_rijndael gcry_rmd160 gcry_rsa gcry_seed gcry_serpent gcry_sha1 gcry_sha256 gcry_sha512 gcry_tiger gcry_twofish gcry_whirlpool luks lvm mdraid09 mdraid1x raid5rec raid6rec

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB or other)?
*******************************************************************************
grub 2.06-r82 (see the grub-version.patch and other attached patches)

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
Our Shim launches only GRUB.

*******************************************************************************
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
Our GRUB launches, in addition, only the Windows Boot Loader, which in turn is supposed to be secure all the time.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
No other components are being launched.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
*******************************************************************************
No.

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
gentoo kernel 5.15.82

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
