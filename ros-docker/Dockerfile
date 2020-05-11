# This is an auto generated Dockerfile for gazebo:gzweb11
# generated from docker_images/create_gzweb_image.Dockerfile.em
FROM osrf/ros:melodic-desktop-full-bionic

RUN apt-get update && apt-get install apt-utils ros-melodic-ros-controllers ros-melodic-ros-control ros-melodic-robot-state-publisher -y
RUN apt-get update && apt-get install ros-melodic-move-base ros-melodic-dwa-local-planner ros-melodic-map-server ros-melodic-ros-monitoring-msgs ros-melodic-amcl -y
RUN apt-get update && apt-get install ros-melodic-rosbridge-suite=0.11.5-1bionic.20200413.135853 -y
RUN apt-get update && apt-get install ros-melodic-turtlebot3-* -y
RUN rosdep update
RUN rosdep fix-permissions

RUN apt-get update && apt-get install python3-apt python3-pip python-tornado python-bson -y
RUN pip3 install -U setuptools pip
RUN pip3 install colcon-ros-bundle
RUN apt-get update && apt-get install xvfb -y

VOLUME /robot_ws
VOLUME /simulation_ws