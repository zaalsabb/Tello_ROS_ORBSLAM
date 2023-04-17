#!/bin/bash

source /opt/ros/melodic/setup.bash
source $ROS_WS/devel/setup.bash

export ROS_IPV6=on
export ROS_HOSTNAME=ig4
export ROS_MASTER_URI=http://master:11311

roslaunch flock_driver orbslam2_no_ui.launch
