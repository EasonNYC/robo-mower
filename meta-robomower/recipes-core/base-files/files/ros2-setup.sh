#!/bin/sh
# ROS2 Environment Setup

export PATH=$PATH:/opt/ros/humble/bin
export PYTHONPATH=$PYTHONPATH:/opt/ros/humble/lib/python3.10/site-packages
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ros/humble/lib
export ROS_DISTRO=humble