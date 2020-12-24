#!/bin/bash
declare ret
# check existence directory
if [[ ! -d /opt/cnvexif ]]; then
    echo 'Making a Directory in /opt. Please Enter your password!'
    sudo mkdir /opt/cnvexif
    sudo cp ./cnvexif.sh /opt/cnvexif
fi
# check existence .sh file
if [[ -d /opt/cnvexif ]]; then
    if [[ ! -f /opt/cnvexif/cnvexif.sh ]]; then
        sudo cp ./cnvexif.sh /opt/cnvexif
    fi
fi

grep 'PATH="$PATH:/opt/cnvexif"' ~/.bashrc 
ret=$?
if [ ! $ret -eq 0 ]; then
    echo 'PATH="$PATH:/opt/cnvexif"' >> ~/.bashrc
    source ~/.bashrc
fi

grep -E "alias\s+cnvexif='cnvexif.sh'" ~/.bashrc 
ret=$?
if [ ! $ret -eq 0 ]; then
    echo "alias cnvexif='cnvexif.sh'">> ~/.bashrc 
    source ~/.bashrc
fi
