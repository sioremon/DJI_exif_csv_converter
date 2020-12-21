# DJI_exif_csv_converter
Convert DJI EXIF information to CSV that could put in GIS software like QGIS. CSV includes file name, date, time, latitude, longitude.

## Environment
- Ubuntu 20.04
- bash
## Dependency
- [exif](https://packages.ubuntu.com/groovy/exif)

## Installation
1. Open Terminal
2. If you have already registered your SSH key on github, execute```git clone git@github.com:sioremon/DJI_exif_csv_converter.git```, otherwise execute ```git clone https://github.com/sioremon/DJI_exif_csv_converter.git```. You can also Download ZIP file.
3. execute ```cd DJI_exif_csv_converter```
4. execute ```chmod +x install.sh```
5. execute ```./install.sh```

## Usage
```
cnvexif DJI0001.jpg
```
```
cnvexif DJI* 
```
Since the command is just an alias to .bashrc, you can change the command wrapper by editing the .bashrc.  

If you are still unable to execute, try reboot first. If you find any implementation problems, please post to issue.

