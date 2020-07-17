#!/bin/bash

echo ""
echo "Running ros-melodic docker for dashboard purposes. In firefox go to localhost:9999 to edit the notebook and enter the listed token. Remember you must have used the -L flag when sshing"
echo ""



rosport=$ROSPORT

if [[ -z "$ROSPORT" ]]; then
    echo "WARNING: didn't provide ROSPORT, setting it to random value, this could result in conflicts." 1>&2
    export ROSPORT=$(($RANDOM%30000+1101))
fi

echo "ROSPORT=$rosport"
gazport=$(($rosport+1))
export ROSPORT=$(($ROSPORT+2))
sed -i '$d' ~/.bashrc
echo "export ROSPORT=$ROSPORT" >> ~/.bashrc

docker run --gpus all -it --rm --shm-size=64g \
-v /home/bag/experiments/JackalTourGuide:/home/bag/catkin_ws \
-v /home/bag/raid/Myhal_Simulation:/home/bag/Myhal_Simulation \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.Xauthority:/home/bag/.Xauthority \
-p 9999:9999 \
-e XAUTHORITY=/home/bag/.Xauthority \
-e DISPLAY=$DISPLAY \
-e ROS_MASTER_URI=http://obelisk:$rosport \
-e GAZEBO_MASTER_URI=http://obelisk:$gazport \
-e ROSPORT=$rosport \
--name "bag-melodic-$ROSPORT" \
docker_ros_melodic \
jupyter lab --ip 0.0.0.0 --port 9999

source ~/.bashrc