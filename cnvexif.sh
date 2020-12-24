#!/bin/bash
declare -a data
IFS=' '
readonly Scale=5
echo 'filename,date,time,latitude,longitude' > exif.csv

for filename in "$@"; do
    data=($(exif ${filename}| grep -e インテル -e 緯度 -e Longitude -e 日時 | sed -e '/オリジナル/d' -e 's/ の EXIF タグ (インテル バイトオーダー)://g' -e 's/緯度/Latitude/g' -e 's/日時/date/g' -e 's/date                  //g' -e 's/Latitude                  //g' -e 's/Longitude           //g' -e 's/|/ /g'|xargs ))
    
    function modify_latitude(){
        Latitude_min=${data[4]%,}
        # 分を度に変換
        Modified_latitude_min=`echo "scale=$Scale; $Latitude_min*60" | bc`
        Latitude_sec=${data[5]}
        tmp1_latitude=`echo "scale=$Scale; $Modified_latitude_min+$Latitude_sec" | bc`
        # 秒を度に変換
        # Modified_latitude_sec=`echo "scale=$Scale; $Latitude_sec/3600"|bc`
        tmp2_latitude=`echo "scale=$Scale; $tmp1_latitude/3600"|bc`
        tmp3_latitude=${data[3]%,}
        latitude=`echo "scale=$Scale; $tmp2_latitude+$tmp3_latitude"|bc`   
    }
    function modify_longitude(){
        Longitude_min=${data[7]%,}
        Modified_longitude_min=`echo "scale=$Scale; $Longitude_min*60" | bc`
        Longitude_sec=${data[8]}
        tmp1_longitude=`echo "scale=$Scale; $Modified_longitude_min+$Longitude_sec" | bc`
        tmp2_longitude=`echo "scale=$Scale; $tmp1_longitude/3600" | bc`
        tmp3_longitude=${data[6]%,}
        longitude=`echo "scale=$Scale; $tmp2_longitude+$tmp3_longitude" | bc`
    }
    modify_latitude
    modify_longitude
    echo "${data[0]},${data[1]},${data[2]},$latitude,$longitude" >> exif.csv
done

# Reference http://d-and-i.hatenablog.com/entry/2016/09/12/090000#%E5%BA%A6%E5%8D%98%E4%BD%8D10%E9%80%B2%E6%95%B0%E5%BD%A2%E5%BC%8F
