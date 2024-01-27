source ./options.conf

if [[ $1 = *[0-9] ]]; then
    PART1="$1p1"
    PART2="$1p2"
    PART3="$1p3"
else
    PART1="$11"
    PART2="$12"
    PART3="$13"
fi

echo "Attempting to unmount if already mounted..."
umount $PART1
umount $PART3
swapoff $PART2

echo "HAVE YOU CHECKED options.conf !!"
read -p "You are about to delete ALL data on $1, proceed? [y/n] " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]] then
    echo "Exited."
    exit 0
fi