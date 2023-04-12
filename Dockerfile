FROM osrf/ros:melodic-desktop-full
ENV ROS_DISTRO melodic

# update
RUN apt-get -y update && \
    apt-get -y install git \
                       wget \
                       libeigen3-dev ffmpeg \
                       python-imaging-tk

# install cv and pcl tools for ros
RUN apt-get install ros-$ROS_DISTRO-cv-bridge ros-$ROS_DISTRO-pcl-conversions ros-$ROS_DISTRO-tf ros-$ROS_DISTRO-message-filters ros-$ROS_DISTRO-image-transport* ros-$ROS_DISTRO-rospy-message-converter -y

# define catkin workspace
ENV ROS_WS $HOME/catkin_ws
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS

# install build tools
RUN apt-get update && apt-get install -y \
      python-catkin-tools \
      git \
    && rm -rf /var/lib/apt/lists/*

# copy files to docker image
COPY ./ $ROS_WS/src/Tello_ROS_ORBSLAM/

# install pangolin
# WORKDIR /
# RUN apt-get -y install libgl1-mesa-dev libglew-dev libxkbcommon-dev
# COPY ./install_pangolin.sh install_pangolin.sh
# RUN ./install_pangolin.sh

# Tello_ROS_ORBSLAM setup
WORKDIR $ROS_WS
RUN cp $ROS_WS/src/Tello_ROS_ORBSLAM/h264decoder/libh264decoder.so /usr/local/lib/python2.7/dist-packages
WORKDIR $ROS_WS/src/Tello_ROS_ORBSLAM/TelloPy
RUN python setup.py install

# build ros package source
WORKDIR $ROS_WS
RUN catkin config \
      --extend /opt/ros/$ROS_DISTRO && \
    catkin build

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# setup ros environment
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source $ROS_WS/devel/setup.bash" >> ~/.bashrc

# setup entrypoint
ADD ros-entrypoint.sh /ros-entrypoint.sh
RUN chmod +x /ros-entrypoint.sh
ENTRYPOINT [ "/ros-entrypoint.sh" ]
