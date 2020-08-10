#!/bin/bash

echo ""
echo "Running ros-melodic docker. Remember you can set ROSPORT to a custom value"
echo ""

rosport=$ROSPORT

detach=false
command=""

while getopts dc: option
do
case "${option}"
in
d) detach=true;; 
c) command=${OPTARG};;
esac
done

if [ -n "$command" ]; then
  echo -e "Running command $command\n"
fi

if [[ -z "$ROSPORT" ]]; then
    echo "WARNING: didn't provide ROSPORT, setting it to 1100"
    export ROSPORT=1100
fi

last_line=$(tail -1 ~/.bashrc)
s=${last_line:0:14}
if [[ "$s" == "export ROSPORT" ]]; then
    sed -i '$d' ~/.bashrc
fi

echo "ROSPORT=$rosport"
gazport=$(($rosport+1))
export ROSPORT=$(($ROSPORT+2))
echo "export ROSPORT=$ROSPORT" >> ~/.bashrc


if [ "$detach" = true ] ; then
    docker run -d --gpus all -it --rm --shm-size=64g \
    -v /home/bag/experiments/JackalTourGuide:/home/bag/catkin_ws \
    -v /home/bag/raid/Myhal_Simulation:/home/bag/Myhal_Simulation \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/home/bag/.Xauthority \
    -v /home/bag/.vimrc:/home/bag/.vimrc \
    -v /home/bag/.vim/:/home/bag/.vim \
    --net=host \
    -e XAUTHORITY=/home/bag/.Xauthority \
    -e DISPLAY=$DISPLAY \
    -e ROS_MASTER_URI=http://obelisk:$rosport \
    -e GAZEBO_MASTER_URI=http://obelisk:$gazport \
    -e ROSPORT=$rosport \
    --name "bag-melodic-$ROSPORT" \
    docker_ros_melodic \
    $command 
else
    docker run --gpus all -it --rm --shm-size=64g \
    -v /home/bag/experiments/JackalTourGuide:/home/bag/catkin_ws \
    -v /home/bag/raid/Myhal_Simulation:/home/bag/Myhal_Simulation \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/home/bag/.Xauthority \
    -v /home/bag/.vimrc:/home/bag/.vimrc \
    -v /home/bag/.vim/:/home/bag/.vim \
    --net=host \
    -e XAUTHORITY=/home/bag/.Xauthority \
    -e DISPLAY=$DISPLAY \
    -e ROS_MASTER_URI=http://obelisk:$rosport \
    -e GAZEBO_MASTER_URI=http://obelisk:$gazport \
    -e ROSPORT=$rosport \
    --name "bag-melodic-$ROSPORT" \
    docker_ros_melodic \
    $command 
fi

source ~/.bashrc
