#!/bin/bash
echo 'Making a Directory in /opt. Please Enter your password!'
sudo mkdir /opt/shell
sudo cp ./exif_csv_converter.sh /opt/shell
echo 'PATH="$PATH:/opt/shell"' >> ~/.bashrc
echo "alias cnvexif='exif_csv_converter.sh'">> ~/.bashrc
source ~/.bashrc