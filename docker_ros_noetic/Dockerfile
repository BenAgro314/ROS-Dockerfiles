#FROM osrf/ros:noetic-desktop-full
FROM vistart/cuda:10.1-cudnn7-runtime-ubuntu20.04

RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN apt update
RUN apt upgrade -y --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y --no-install-recommends
RUN apt-get update
RUN apt-get install gcc g++ python3 python3-pip python3-dev -y --no-install-recommends
RUN apt-get install gedit -y --no-install-recommends
RUN apt-get update
RUN apt-get install firefox -y --no-install-recommends
RUN apt-get install wget -y --no-install-recommends
RUN apt-get install git -y --no-install-recommends
RUN apt-get install xvfb -y --no-install-recommends   
RUN apt-get install vim -y --no-install-recommends
RUN pip3 install --upgrade pip
RUN pip3 install setuptools
RUN pip3 install numpy scikit-learn matplotlib PyYAML
RUN pip3 install torch==1.5.1+cu101 torchvision==0.6.1+cu101 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip3 install PyQt5
RUN apt install pyqt5-dev-tools pyqt5-dev -y --no-install-recommends

RUN apt update
RUN apt install curl gnupg2 lsb-release -y --no-install-recommends
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -

RUN apt-get update --fix-missing
RUN apt install ros-noetic-desktop-full -y --no-install-recommends


RUN apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y --no-install-recommends

RUN apt-get install ros-noetic-rgbd-launch -y --no-install-recommends
RUN apt-get install ros-noetic-openni2* -y --no-install-recommends
RUN apt-get install ros-noetic-octomap* -y --no-install-recommends
RUN apt-get install ros-noetic-ros-control -y --no-install-recommends
RUN apt-get install ros-noetic-tf2* -y --no-install-recommends
RUN apt-get install ros-noetic-navigation* -y --no-install-recommends
RUN apt-get install ros-noetic-gazebo* -y --no-install-recommends

RUN groupadd -g 1090 myhal_sim
RUN groupadd -g 1001 raid
RUN useradd -ms /bin/bash -u 1085 bag
RUN adduser bag myhal_sim
RUN adduser bag raid
RUN apt-get install python3-tk -y --no-install-recommends
WORKDIR /home/bag/catkin_ws


USER bag
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN echo "source /home/bag/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:/home/bag/catkin_ws/src/myhal_simulator/models" >> ~/.bashrc
RUN echo "export GAZEBO_RESOURCE_PATH=${GAZEBO_RESOURCE_PATH}:/home/bag/catkin_ws/src/myhal_simulator/models" >> ~/.bashrc
RUN echo "export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:/home/bag/catkin_ws/devel/lib" >> ~/.bashrc
RUN echo "export USER=bag" >> ~/.bashrc

ENV ROS_DISTRO noetic
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

COPY entrypoint.sh /home/entrypoint.sh
ENTRYPOINT ["/home/entrypoint.sh"]
CMD ["bash"]

