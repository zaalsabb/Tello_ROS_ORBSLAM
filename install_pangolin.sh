#!/bin/bash
git clone https://github.com/stevenlovegrove/Pangolin.git
sudo apt install libgl1-mesa-dev
sudo apt install libglew-dev
sudo apt-get install libxkbcommon-dev
cd Pangolin
mkdir build
cd build
cmake ..
make
sudo make install
