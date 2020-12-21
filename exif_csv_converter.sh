#!/bin/bash
declare -a data
IFS=' '
readonly Scale=12
echo 'filename,date,time,latitude,longitude' > exif.csv
ls *.jpg |
while read filename; do
    data=($(exif ${filename}| grep -e インテル -e 緯度 -e Longitude -e 日時 | sed -e '/オリジナル/d' -e 's/ の EXIF タグ (インテル バイトオーダー)://g' -e 's/緯度/Latitude/g' -e 's/日時/date/g' -e 's/date                  //g' -e 's/Latitude                  //g' -e 's/Longitude           //g' -e 's/|/ /g'|xargs ))
    
    function modify_latitude(){
        Latitude_min=${data[4]%,}
        # 分を度に変換
        Modified_latitude_min=`echo "scale=$Scale; $Latitude_min/60" | bc`
        Latitude_sec=${data[5]}
        # 秒を度に変換
        Modified_latitude_sec=`echo "scale=$Scale; $Latitude_sec/3600"|bc`
        
        tmp_latitude=${data[3]%,}
        latitude=`echo "scale=$Scale; $tmp_latitude+$Modified_latitude_min+$Modified_latitude_sec"|bc`   
    }
    function modify_longitude(){
        Longitude_min=${data[7]%,}
        Modified_longitude_min=`echo "scale=$Scale; $Longitude_min/60" | bc`
        Longitude_sec=${data[8]}
        Modified_longitude_sec=`echo "scale=$Scale; $Longitude_sec/3600" | bc`
        tmp_longitude=${data[6]%,}
        longitude=`echo "scale=$Scale; $tmp_longitude+$Modified_longitude_min_$Modified_longitude_sec" | bc`
    }
    modify_latitude
    modify_longitude
    echo "${data[0]},${data[1]},${data[2]},$latitude,$longitude" >> exif.csv
done


