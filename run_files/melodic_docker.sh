#!/bin/bash

echo ""
echo "Running ros-melodic docker. Remember you can set ROSPORT"
echo ""

if [ -n "$1" ]; then
  echo -e "Running command $1\n"
fi

rosport=$ROSPORT

# while getopts p: option
# do
# case "${option}"
# in
# p) rosport=${OPTARG};; 
# esac
# done

if [[ -z "$ROSPORT" ]]; then
    echo "WARNING: didn't provide ROSPORT, setting it to random value, this could result in conflicts." 1>&2
    export ROSPORT=$(($RANDOM%30000+1101))
fi

echo "ROSPORT= $rosport"
gazport=$(($rosport+1))
export ROSPORT=$(($ROSPORT+2))
sed -i '$d' ~/.bashrc
echo "export ROSPORT=$ROSPORT" >> ~/.bashrc


docker run --gpus all -it --rm --shm-size=64g \
-v /home/bag/experiments/JackalTourGuide:/home/bag/catkin_ws \
-v /home/bag/raid/Myhal_Simulation/simulated_runs:/home/bag/Myhal_Simulation/simulated_runs \
-v /home/bag/raid/Myhal_Simulation/annotated_frames:/home/bag/Myhal_Simulation/annotated_frames \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.Xauthority:/home/bag/.Xauthority \
--net=host \
-e XAUTHORITY=/home/bag/.Xauthority \
-e DISPLAY=$DISPLAY \
-e ROS_MASTER_URI=http://obelisk:$rosport \
-e GAZEBO_MASTER_URI=http://obelisk:$gazport \
-e ROSPORT=$rosport \
--name "Bag-$ROSPORT" \
docker_ros_melodic \
$1
