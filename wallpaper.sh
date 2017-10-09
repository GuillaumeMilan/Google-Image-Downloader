#!/bin/bash 

echo "Nous allons changer aléatoirement votre fond d'écran"
cd ~
rm -rf .RandomWallPaperByGuignomes
mkdir .RandomWallPaperByGuignomes
cd .RandomWallPaperByGuignomes
wget -q http://www.palabrasaleatorias.com/mots-aleatoires.php?fs=1&fs2=1&Submit=Nouveau+mot 
sleep 3
var=$(awk '/<div style="font-size:3em; color:#6200C5;">/{getline; print}' *)
mot=$(echo $var | sed -n "s/<\/div>//p")
rm *

exit 0
