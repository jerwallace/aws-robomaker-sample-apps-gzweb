#!/bin/bash

TB3_MODELS=/app/turtlebot3_description_reduced_mesh/share/turtlebot3_description_reduced_mesh/models/turtlebot3_description_reduced_mesh
cd models/turtlebot3_description_reduced_mesh/
mkdir -p $TB3_MODELS
cd $TB3_MODELS
touch model.config
ln -s ../../meshes meshes 

DIR=/root/gzweb
mkdir -p $DIR/http/client/assets
cd $DIR
./get_local_models.py $DIR/http/client/assets
./webify_models_v2.py $DIR/http/client/assets
mkdir $DIR/http/client/assets/models && mv $DIR/http/client/assets/aws* $DIR/http/client/assets/models/

source /sim_app/setup.bash && roslaunch $ROS_PACKAGE_SIM $ROS_LAUNCH_FILE_SIM &>/dev/null & npm start
#source /robot_app/setup.bash && roslaunch $ROS_PACKAGE_ROBOT $ROS_LAUNCH_FILE_ROBOT &>/dev/null &

