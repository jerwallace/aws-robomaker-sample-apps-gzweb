# This is an auto generated Dockerfile for gazebo:gzweb11
# generated from docker_images/create_gzweb_image.Dockerfile.em
FROM ros:melodic

RUN apt update && apt install ros-melodic-desktop-full python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential -y
RUN apt update && apt install ros-melodic-ros-controllers ros-melodic-ros-control ros-melodic-robot-state-publisher -y
RUN apt update && apt install ros-melodic-move-base ros-melodic-dwa-local-planner ros-melodic-map-server ros-melodic-ros-monitoring-msgs ros-melodic-amcl -y
RUN apt update && apt install ros-melodic-rosbridge-suite=0.11.5-1bionic.20200413.135853 -y
RUN apt update && apt install ros-melodic-turtlebot3-description -y
RUN rosdep init
RUN rosdep update
RUN rosdep fix-permissions

VOLUME /robot_app
VOLUME /sim_app