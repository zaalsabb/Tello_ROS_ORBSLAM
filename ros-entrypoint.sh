#!/bin/bash

source /opt/ros/melodic/setup.bash
source $ROS_WS/devel/setup.bash

export ROS_HOSTNAME=localhost
export ROS_MASTER_URI=http://localhost:11311

roslaunch flock_driver orbslam2_no_ui.launch
