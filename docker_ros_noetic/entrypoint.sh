#!/usr/bin/env bash

set -e

source /opt/ros/noetic/setup.bash
source /home/bag/catkin_ws/devel/setup.bash
export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:/home/bag/catkin_ws/src/myhal_simulator/models
export GAZEBO_RESOURCE_PATH=${GAZEBO_RESOURCE_PATH}:/home/bag/catkin_ws/src/myhal_simulator/models
export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:/home/bag/catkin_ws/devel/lib
export USER=bag

exec "$@"


