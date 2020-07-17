#!/bin/bash

echo ""
echo "Running ros-melodic and ros-noetic docker. Remember you can set ROSPORT to a custom value"
echo ""



rosport=$ROSPORT

command=""

while getopts c: option
do
case "${option}"
in
c) command=${OPTARG};;
esac
done

if [ -n "$command" ]; then
  echo -e "Running command $command\n"
fi

if [[ -z "$ROSPORT" ]]; then
    echo "WARNING: didn't provide ROSPORT, setting it to random value, this could result in conflicts." 1>&2
    export ROSPORT=$(($RANDOM%30000+1101))
fi

echo "ROSPORT=$rosport"
gazport=$(($rosport+1))
export ROSPORT=$(($ROSPORT+2))
sed -i '$d' ~/.bashrc
echo "export ROSPORT=$ROSPORT" >> ~/.bashrc


docker run -d --gpus all -it --rm --shm-size=64g \
-v /home/bag/experiments/JackalTourGuide:/home/bag/catkin_ws \
-v /home/bag/raid/Myhal_Simulation:/home/bag/Myhal_Simulation \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.Xauthority:/home/bag/.Xauthority \
--net=host \
-e XAUTHORITY=/home/bag/.Xauthority \
-e DISPLAY=$DISPLAY \
-e ROS_MASTER_URI=http://obelisk:$rosport \
-e GAZEBO_MASTER_URI=http://obelisk:$gazport \
-e ROSPORT=$rosport \
--name "bag-melodic-$ROSPORT" \
docker_ros_melodic \
$command &&
docker run -d --gpus all -it --rm --shm-size=64g \
-v /home/hth/raid/hth/Data/MyhalSim:/home/bag/Data/MyhalSim \
-v /home/bag/experiments/JackalNoetic:/home/bag/catkin_ws \
-v /home/bag/raid/Myhal_Simulation:/home/bag/Myhal_Simulation \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/.Xauthority:/home/bag/.Xauthority \
--net=host \
-e XAUTHORITY=/home/bag/.Xauthority \
-e DISPLAY=$DISPLAY \
-e ROS_MASTER_URI=http://obelisk:$rosport \
-e GAZEBO_MASTER_URI=http://obelisk:$gazport \
-e ROSPORT=$rosport \
--name "bag-noetic-$ROSPORT" \
docker_ros_noetic \
"./classifier.sh"




