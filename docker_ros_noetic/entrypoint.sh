#!/usr/bin/env bash

set -e

source /opt/ros/noetic/setup.bash
source /home/bag/catkin_ws/devel/setup.bash
export USER=bag

exec "$@"


