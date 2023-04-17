#!/bin/bash

set -e # exit on first error

now=$(date +"%Y-%m-%d-%H-%M-%S")
bagDir=~
echo "Collecting bag file..."
echo "Saving to: "
echo "$bagDir/drone_$now.bag"
rosbag record -O $bagDir/drone_$now.bag \
/tf \
/tello/camera/camera_info \
/tello/camera/image_raw/compressed \
/tello/real_world_pos


