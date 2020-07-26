#FROM docker.io/abychko/rhel-8
FROM centos:centos8

# RUN rm /etc/yum.repos.d/CentOS-Media.repo
RUN echo 10
COPY rpmmacros /root/.rpmmacros
COPY rhel8-gcc.repo /etc/yum.repos.d/
RUN yum -y --enablerepo=rhel8-gcc update
RUN yum -y --enablerepo=rhel8-gcc install \
	wget rpm-build gcc make elfutils-libelf-devel git \
	gnu-efi gnu-efi-devel openssl openssl-devel pesign
RUN wget https://people.redhat.com/~pjones/shim-rhel-8/shim-unsigned-x64-15-7.el8.src.rpm https://people.redhat.com/~pjones/shim-rhel-8/redhat-release-8.3-0.2.el8.x86_64.rpm
RUN rpm -ivh shim-unsigned-x64-15-7.el8.src.rpm
# RUN yum-builddep -y --enablerepo=PowerTools --enablerepo=Devel --enablerepo=rhel8-gcc /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpm -e centos-release --noscripts --nodeps
RUN rpm -Uvh /redhat-release-8.3-0.2.el8.x86_64.rpm --force
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimia32.efi /
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-15-7.el8.x86_64.rpm  | cpio -diu
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15-7.el8.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15-7.el8/*/shim*.efi
RUN echo 2
RUN hexdump -Cv ./usr/share/shim/15-7.el8/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv ./usr/share/shim/15-7.el8/ia32/shimia32.efi > built-ia32.hex
RUN hexdump -Cv /shimia32.efi > orig-ia32.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/15-7.el8/x64/shimx64.efi
RUN objdump -h /usr/share/shim/15-7.el8/ia32/shimia32.efi
RUN diff -u orig-ia32.hex built-ia32.hex
RUN diff -u orig-x64.hex built-x64.hex
RUN pesign -h -P -i /usr/share/shim/15-7.el8/ia32/shimia32.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/15-7.el8/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/15-7.el8/x64/shimx64.efi /shimx64.efi /usr/share/shim/15-7.el8/ia32/shimia32.efi /shimia32.efi
