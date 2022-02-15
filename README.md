This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
We are Adaptech s.r.o. (https://www.adaptech.cz), distributor of various electronic, often computer-based devices, that aid mainly visually impaired in their way for independence in their life. Our company is small, employing no more than 20 employees. Almost all employees including me are blind or visually impaired. We, however, do have our development department and invest much money and effort into our own development.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
AOS is a self-voiced and magnified application mainly for blind and visually impaired people whose purpose is to create backup / restore the operating system.

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
For the AOS system to be loadable even before Windows boots, we have been utilizing the GRUB2 bootloader, and to satisfy requirements of modern architectures with Secure Boot enabled, we have found Shim as the loader of choice for us. As almost none of our customers are technically skilled persons, everything has to be designed this way. Thus we are not distributing MOK Manager and the Fallback do prevent MOK management because we don't want our customers to mess with their preconfigured system and we want to make things as simple as they can be, i.e. if the Shim does not verify our kernel signed by our EV key, it does not bother the user with MOKs, allowing us to get clear feedback on what has happened and to take the computer for service. Considering AOS Manager, SHIM's role is even more evident as it has to be part of AOS installations performed by staff of commercial subjects, thus our Shim gets to the subject's customers.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Petr Řehák
- Position: developer
- Email address: rehak@adaptech.cz
- PGP key fingerprint:
I am uncertain about this requirement. We don't have anyone else in our company who would care about this matter. We aren't in contact with anybody in the Linux community nor are we planning being part of it as we don't do Linux much. We don't make use of PGP at all.

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: František Žána
- Position: executive director
- Email address: zana@adaptech.cz
- PGP key fingerprint: see above

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
The binary has been built first from the 15.4 tag, then from the tarball, both identical by their hexdump.

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
[your url here]

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
No patches have been applied so far.

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
Our GRUB is the upstream 2.06 one with our patch set, so these CVEs are included.

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
Upstream GRUB2 shim_lock verifier

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
We haven't shipped Shim along with GRUB2 yet.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
Our gentoo kernels 5.10.83 and 5.15.16 meet this requirement.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
We don't use that.

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
This certificate has not been used for this purpose yet.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
-------------------------------------------------------------------------------
- Ubuntu 20.04
- gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
- binutils 2.34
- GNU-EFI 3.0.12
- see our dockerfile

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
The file build.log contains the whole log from `make clean` to `make install`.

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
[your text here]
