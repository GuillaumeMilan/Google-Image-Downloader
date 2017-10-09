#!/bin/bash

pip install --user selenium 
pip install --user futures 

npm install phantomjs

current_dir=$(pwd)
echo "export PATH=\$PATH:$current_dir/node_modules/phantomjs/lib/phantom/bin" >> ~/.bashrc
source ~/.bashrc
exit 0
