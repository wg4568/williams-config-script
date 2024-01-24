sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git ~/software/yay-bin
cd ~/software/yay-bin
makepkg -si --noconfirm
cd -
