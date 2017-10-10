#!/bin/bash 

echo "Randomly setting your wallpaper..."
current_dir=$(pwd)
cd ~
mkdir .RandomWallPaperByGuignomes &> /dev/null
if [ $? -eq 1 ] 
then 
    read -p "~/.RandomWallPaperByGuignomes already exist: do you want to remove it? (y/n) " answer
    if [ $answer = "y" ] 
    then 
	rm -rf ~/.RandomWallPaperByGuignomes
	mkdir .RandomWallPaperByGuignomes
    else 
	exit 1
    fi
fi
cd .RandomWallPaperByGuignomes
wget -q http://www.palabrasaleatorias.com/mots-aleatoires.php?fs=1&fs2=1&Submit=Nouveau+mot 
sleep 3
var=$(awk '/<div style="font-size:3em; color:#6200C5;">/{getline; print}' *)
mot=$(echo $var | sed -n "s/<\/div>//p")
echo "Your word is : $mot"
rm *
cd $current_dir
rm download_images/*
python image_downloader.py --safe-mode "$mot wallpaper" > /dev/null
result=$(ls download_images/Google_0008.*)
if [ $? -eq 2 ] 
then 
    for file in download_images/* 
    do 
	result=$file
	if [ $? -ne 2 ] 
	then 
	    echo "Choosing the image: $file"
	    gsettings set org.gnome.desktop.background picture-uri file://$current_dir/$result
	    rm -rf ~/.RandomWallPaperByGuignomes
	    exit 0
	fi 
    done 
    echo "Error on downloading the images on Google exiting now!!!"
    exit 1
fi 
gsettings set org.gnome.desktop.background picture-uri file://$current_dir/$result
rm -rf ~/.RandomWallPaperByGuignomes
exit 0
