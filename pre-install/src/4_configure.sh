arch-chroot /mnt ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
arch-chroot /mnt hwclock --systohc

sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /mnt/etc/locale.gen
echo 'LANG=en_US.UTF' > /mnt/etc/locale.conf
arch-chroot /mnt locale-gen

echo $HOSTNAME > /mnt/etc/hostname
arch-chroot /mnt systemctl enable NetworkManager

arch-chroot /mnt passwd

read -p "User to create: " NEWUSER
arch-chroot /mnt useradd -m -s /bin/bash $NEWUSER
echo "$NEWUSER ALL=(ALL:ALL) ALL" | arch-chroot /mnt EDITOR="tee -a" visudo
arch-chroot /mnt passwd $NEWUSER
cp -rf ./.postinstall /mnt/home/$NEWUSER/postinstall
