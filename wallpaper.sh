#!/bin/bash 

echo "Nous allons changer aléatoirement votre fond d'écran"
current_dir=$(pwd)
echo "Nous sommes dans le dossier $current_dir"
cd ~
rm -rf .RandomWallPaperByGuignomes
mkdir .RandomWallPaperByGuignomes
cd .RandomWallPaperByGuignomes
wget -q http://www.palabrasaleatorias.com/mots-aleatoires.php?fs=1&fs2=1&Submit=Nouveau+mot 
sleep 3
var=$(awk '/<div style="font-size:3em; color:#6200C5;">/{getline; print}' *)
mot=$(echo $var | sed -n "s/<\/div>//p")
echo "Votre mot est : $mot"
rm *
cd $current_dir
python image_downloader.py --safe-mode "$mot wallpaper" > /dev/null
echo "Nous sommes dans le dossier $current_dir"
gsettings set org.gnome.desktop.background picture-uri file://$current_dir/download_images/Google_0008.jpeg
exit 0
