Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag - https://github.com/rehakp/shim-review/tree/adaptech-shim-x86_64-20220314
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files - https://github.com/rehakp/shim-review/blob/adaptech-shim-x86_64-20220314/grub-patches.tgz
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries


###### What organization or people are asking to have this signed:
`We are Adaptech s.r.o. (https://www.adaptech.cz), distributor of various electronic, often computer-based devices, that aid mainly visually impaired in their way for independence in their life. Our company is small, employing no more than 20 employees. Almost all employees including me are blind or visually impaired. We, however, do have our development department and invest much money and effort into our own development.`

###### What product or service is this for:
`AOS is a self-voiced and magnified application mainly for blind and visually impaired people whose purpose is to create backup / restore the operating system.`

###### Please create your shim binaries starting with the 15.4 shim release tar file:
###### https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
###### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
###### the appropriate gnu-efi source.
###### Please confirm this as the origin your shim.
`The binary has been built first from the 15.4 tag, then from the tarball, both identical by their hexdump.`

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
`For the AOS system to be loadable even before Windows boots, we have been utilizing the GRUB2 bootloader, and to satisfy requirements of modern architectures with Secure Boot enabled, we have found Shim as the loader of choice for us. As almost none of our customers are technically skilled persons, everything has to be designed this way. Thus we are not distributing MOK Manager and the Fallback to prevent MOK management because we don't want our customers to mess with their preconfigured system and we want to make things as simple as they can be, i.e. if the Shim does not verify our kernel signed by our EV key, it does not bother the user with MOKs, allowing us to get clear feedback on what has happened and to take the computer for service. Considering AOS Manager, SHIM's role is even more evident as it has to be part of AOS installations performed by staff of commercial subjects, thus our Shim gets to the subject's customers.`

###### How do you manage and protect the keys used in your SHIM?
`Our keys are on a HSM from our Authenticode certificate authority, exclusively in our hands, in the building where our company is based. This HSM disallows from its nature to export private keys.`

###### Do you use EV certificates as embedded certificates in the SHIM?
`Yes.`

###### If you use new vendor_db functionality, are any hashes allow-listed, and if yes: for what binaries ?
`We don't use that.`

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
`Our gentoo kernels 5.10.83 and 5.15.16 meet this requirement.`

###### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372,
###### CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779,
###### CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308,
###### CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
###### ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
###### and if you are shipping the shim_lock module CVE-2021-3418
###### fixed ?
`We are on upstream GRUB 2.06 + our patch set that does not affect security so we are OK.`

###### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata
###### ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
###### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim
###### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation
`sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.adaptech,1,Adaptech s.r.o.,grub,2.06-r80,info@adaptech.cz`

##### Were your old SHIM hashes provided to Microsoft ?
`Yes, but they got never signed, thus were never used.`

##### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
##### CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
##### CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
##### grub2 bootloaders can not be verified ?
`No.`

##### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
##### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
`Upstream grub2 shim_lock verifier`

##### Which modules are built into your signed grub image?
`We haven't built any modules into the GRUB image yet.`

###### What is the origin and full version number of your bootloader (GRUB or other)?
`grub 2.06-r80 (see the grub-version.patch and other attached patches)`

###### If your SHIM launches any other components, please provide further details on what is launched
`Our Shim launches only GRUB.`

###### If your GRUB2 launches any other binaries that are not Linux kernel in SecureBoot mode,
###### please provide further details on what is launched and how it enforces Secureboot lockdown
`Our GRUB launches, in addition, only the Windows Boot Loader, which in turn is secure all the time.`

###### If you are re-using a previously used (CA) certificate, you
###### will need to add the hashes of the previous GRUB2 binaries
###### exposed to the CVEs to vendor_dbx in shim in order to prevent
###### GRUB2 from being able to chainload those older GRUB2 binaries. If
###### you are changing to a new (CA) certificate, this does not
###### apply. Please describe your strategy.
`This certificate hasn't been used for this purpose yet.`

###### How do the launched components prevent execution of unauthenticated code?
`No other components are being launched.`

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
`No.`

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
`gentoo kernel 5.10.83 for AOS 2, gentoo kernel 5.15.16 for AOS Manager`

###### What changes were made since your SHIM was last signed?
`No Shim was ever signed to us.`

###### What is the SHA256 hash of your final SHIM binary?
`b641a1d47ba002c0bc73b101b86471b618a5cc8895c150e61402f26d93a2f725`
