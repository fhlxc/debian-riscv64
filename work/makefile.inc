export CHROOT_PATH=work/debian-riscv64-chroot

chroot: ../rootfs.tar.xz

../qemu/riscv64-linux-user/qemu-riscv64:
	(cd ../qemu; ./configure --static --disable-system --target-list=riscv64-linux-user)
	make -C ../qemu -j 4

../rootfs.tar.xz: work/mybootstrap.sh ../qemu/riscv64-linux-user/qemu-riscv64
	sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 06AED62430CB581C 8B48AD6246925553 7638D0442B90D010 04EE7237B7D453EC DA1B2CEA81DCBC61
	sh work/mybootstrap.sh
	sudo tar cJf - -C ${CHROOT_PATH} . > $@

deps:
	@find . -path ./work -prune -o -path ./.git -prune -o -print|xargs file|grep RISC-V|cut -d: -f1|xargs riscv64-unknown-elf-readelf -d |grep NEEDED|cut -d: -f2|sort -u

clean:
	rm -rf ${CHROOT_PATH}
