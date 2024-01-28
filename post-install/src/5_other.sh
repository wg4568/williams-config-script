ln -s /mnt/counter ~/counter
sudo systemctl enable sddm
yes | yay -Sy material-kwin-decoration-git
read -p "Would you like to install nvidia and alsa firmware? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] then
    sudo pacman -S nvidia alsa-firmware alsa-utils
fi
echo "Done. Please reboot."