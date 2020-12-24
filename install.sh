#!/bin/bash
echo 'Making a Directory in /opt. Please Enter your password!'
sudo mkdir /opt/shell
sudo cp ./cnvexif.sh /opt/shell
echo 'PATH="$PATH:/opt/shell"' >> ~/.bashrc
echo "alias cnvexif='cnvexif.sh'">> ~/.bashrc 
source ~/.bashrc