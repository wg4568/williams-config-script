#! /bin/bash

WD="./.preinstall"
ROOTHOME="./pre-install/archlive/airootfs/root"
sudo rm -rf $WD $ROOTHOME/.postinstall $ROOTHOME/install.sh $ROOTHOME/options.conf
mkdir -p $WD

sudo cp ./pre-install/options.conf $ROOTHOME
sudo cp -r ./.postinstall $ROOTHOME
cat ./pre-install/src/* >> $ROOTHOME/install.sh

sudo mkarchiso -v -w $WD -o ./builds ./pre-install/archlive
