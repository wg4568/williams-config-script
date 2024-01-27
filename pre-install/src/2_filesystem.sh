mkfs.fat -F 32 $PART1
mkswap $PART2
mkfs.ext4 -F $PART3

mount $PART3 /mnt
mkdir -p /mnt/boot/efi
mount $PART1 /mnt/boot/efi
swapon $PART2