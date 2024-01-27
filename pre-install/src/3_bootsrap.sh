pacman -Syyy
echo $PACKAGES | xargs pacstrap /mnt
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt grub-install $1
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
