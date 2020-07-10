FROM nvcr.io/nvidia/cuda:10.1-cudnn7-runtime

RUN apt update
RUN apt upgrade -y --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y --no-install-recommends
RUN apt-get update
RUN apt-get install gcc g++ python3 python3-pip python3-dev vtk6 -y --no-install-recommends
RUN apt-get install gedit -y --no-install-recommends
RUN apt-get install vim -y --no-install-recommends

RUN apt update
RUN apt install curl gnupg2 lsb-release -y --no-install-recommends
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -

RUN apt update
RUN apt install ros-melodic-desktop-full -y --no-install-recommends

RUN apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential -y --no-install-recommends
RUN rosdep init
RUN rosdep update



RUN apt-get install python-catkin-tools -y --no-install-recommends
RUN apt-get install ros-melodic-velodyne* -y --no-install-recommends
RUN apt-get install ros-melodic-jackal* -y --no-install-recommends
RUN apt-get install ros-melodic-pointcloud-to-laserscan -y --no-install-recommends
RUN apt-get install ros-melodic-rgbd-launch -y --no-install-recommends
RUN apt-get install ros-melodic-range-sensor-layer -y --no-install-recommends
RUN apt-get install ros-melodic-openni2* -y --no-install-recommends
RUN apt-get install ros-melodic-octomap* -y --no-install-recommends
RUN apt-get install ros-melodic-ros-control -y --no-install-recommends
RUN apt-get install ros-melodic-tf2 -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-py -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-kdl -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-ros -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-msgs -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-eigen -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-sensor-msgs -y --no-install-recommends
RUN apt-get install ros-melodic-tf2-geometry-msgs -y --no-install-recommends
RUN apt-get install ros-melodic-people-msgs -y --no-install-recommends
RUN apt-get install ros-melodic-people-velocity-tracker -y --no-install-recommends
RUN apt-get install ros-melodic-navigation* -y --no-install-recommends
RUN apt-get install ros-melodic-people-msgs -y --no-install-recommends
RUN apt-get install ros-melodic-social-navigation-layers -y --no-install-recommends
RUN apt-get install ros-melodic-teleop-twist-keyboard -y --no-install-recommends
#RUN apt-get update && apt-get install -y libgazebo9-dev
RUN apt-get install -y gnome-core --no-install-recommends
RUN apt-get install -y mesa-utils --no-install-recommends

RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2486D2DD83DB69272AFE98867170598AF249743
RUN apt update
RUN apt upgrade -y --no-install-recommends

RUN apt-get install psmisc -y --no-install-recommends

RUN groupadd -g 1090 myhal_sim
RUN groupadd -g 1001 raid
RUN useradd -ms /bin/bash -u 1085 bag
RUN adduser bag myhal_sim
RUN adduser bag raid
RUN apt-get install python3-matplotlib -y --no-install-recommends
RUN apt-get install python3-tk -y --no-install-recommends
USER bag
WORKDIR /home/bag/catkin_ws

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

RUN echo "source /home/bag/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:/home/bag/catkin_ws/src/myhal_simulator/models" >> ~/.bashrc
RUN echo "export GAZEBO_RESOURCE_PATH=${GAZEBO_RESOURCE_PATH}:/home/bag/catkin_ws/src/myhal_simulator/models" >> ~/.bashrc
RUN echo "export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:/home/bag/catkin_ws/devel/lib" >> ~/.bashrc
RUN echo "export USER=bag" >> ~/.bashrc

ENV ROS_DISTRO melodic
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

COPY entrypoint.sh /home/entrypoint.sh
ENTRYPOINT ["/home/entrypoint.sh"]
CMD ["bash"]

