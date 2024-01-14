tar -xf $WORKING_DIR/config.tar.gz -C $WORKING_DIR
CONFIG_DIR="$WORKING_DIR/config"

# Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

# Repositories
sudo add-apt-repository ppa:lakinduakash/lwh -y

# Install apt packages
sudo apt-get install $(echo $APT_PACKAGES | tr '\n' ' ') -y

# Install snap packages
sudo snap install firefox slack bitwarden yubioath-desktop
sudo snap install code --classic

# Install NVM and Node 20
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 20
nvm use 20

# Install AWS CLI
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip
unzip /tmp/awscliv2.zip -d /tmp/
sudo /tmp/aws/install
rm -rf /tmp/aws /tmp/awscliv2.zip

# Install other software
npm i -g yarn prettier
pip3 install konsave exif plotly pandas

# Configuration
mkdir ~/.aws && cp -r $CONFIG_DIR/aws/* ~/.aws/
cp $CONFIG_DIR/user-dirs.dirs ~/.config/user-dirs.dirs
cp $CONFIG_DIR/aliases.sh ~/.aliases
cp $CONFIG_DIR/tmux.conf ~/.tmux.conf
sudo cp $CONFIG_DIR/wireguard.conf /etc/wireguard/wg0.conf
sudo cp $CONFIG_DIR/conky.conf /etc/conky/

# Update user directories directories
mkdir ~/desk
mv ~/Desktop ~/Templates ~/Public ~/Documents ~/Music ~/Pictures ~/Videos ~/desk
mv ~/Downloads ~/downloads

source ~/.config/user-dirs.dirs
ESC_HOME="$(echo $HOME | sed 's/\//\\\//g')"
sed -i "s/$ESC_HOME\/Desktop/$(echo $XDG_DESKTOP_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Documents/$(echo $XDG_DOCUMENTS_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Music/$(echo $XDG_MUSIC_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Pictures/$(echo $XDG_PICTURES_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Public/$(echo $XDG_PUBLICSHARE_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Templates/$(echo $XDG_TEMPLATES_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Videos/$(echo $XDG_VIDEOS_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
sed -i "s/$ESC_HOME\/Downloads/$(echo $XDG_DOWNLOAD_DIR | sed 's/\//\\\//g')/g" ~/.local/share/user-places.xbel
xdg-user-dirs-update

# Other file stuff
mkdir ~/projects ~/bin
cp $CONFIG_DIR/wallpaper.png ~/desk/Pictures/wallpaper.png
cp $CONFIG_DIR/bin/* ~/bin/
chmod +x ~/bin/*
sudo mkdir /mnt/counter
sudo mkdir /mnt/media

# Update bashrc
echo 'PATH="$HOME/.local/bin:$HOME/bin:$PATH"' >> ~/.bashrc
echo '. ~/.aliases' >> ~/.bashrc

# Desktop customization with konsave
~/.local/bin/konsave -i $CONFIG_DIR/konsave.knsv
~/.local/bin/konsave -a konsave
~/.local/bin/konsave -r konsave

# Set wallpaper (https://www.reddit.com/r/kde/comments/65pmhj/change_wallpaper_from_terminal/)
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
var Desktops = desktops();
for (i = 0; i<Desktops.length; i++) {
        d = Desktops[i];
        d.wallpaperPlugin = \"org.kde.image\";
        d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
        d.writeConfig(\"Image\", \"file://$XDG_PICTURES_DIR/wallpaper.png\");
}"

# Conky on autostart
mkdir ~/.config/autostart
cp /usr/share/applications/conky.desktop ~/.config/autostart/

# Git stuff
git config --global user.email "william@madebycounter.com"
git config --global user.name "William Gardner"
for u in $(echo $GIT_REPOS); do git clone $u ~/projects/$(basename $u); done

# Clean up
rm -rf $WORKING_DIR

# Done!
neofetch
echo "Configuration done! Please log out and log back in again."
