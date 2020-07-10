#!/bin/bash

echo ""
echo "Building image docker_ros_box"
echo ""

docker image build --shm-size=64g -t docker_ros_noetic .
