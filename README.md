A collection of dockerfiles for ROS

Notes on manipulating containers:
- use -d flag in docker run command to run the container in detached mode (no interactive terminal)
- To run master detached: ./{ros-distro}-docker "./master.sh +options"
- To attach to a container: docker attach {container name}
- To detach from a terminal: press ctrl-p then ctrl-q