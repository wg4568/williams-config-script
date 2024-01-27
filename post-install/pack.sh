WD="./.postinstall"
sudo rm -rf $WD
mkdir -p $WD/files

while read -r -a line
do
    if [[ ${#line[@]} -gt 1 && ${line[1]} != "CREATE" ]]; then
        src=$(eval echo "${line[0]}")
        dst=$WD/files/${line[1]}
        sudo cp -r $src $dst
    fi
done < ./post-install/options/files.txt

cp -rf ./post-install/options $WD

echo '#! /bin/bash' > $WD/install.sh
cat ./post-install/src/* >> $WD/install.sh
chmod +x $WD/install.sh
