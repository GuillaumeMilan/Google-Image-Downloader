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
python image_downloader.py --safe-mode "$mot wallpaper" > /dev/null
gsettings set org.gnome.desktop.background picture-uri file://$current_dir/download_images/Google_0008.jpeg
rm -rf ~/.RandomWallPaperByGuignomes
exit 0
