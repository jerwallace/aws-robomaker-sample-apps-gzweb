#!/bin/bash
DEBUG=$DEBUG
TB3_MODELS=/simulation_ws/install/turtlebot3_description_reduced_mesh/share/turtlebot3_description_reduced_mesh/models/turtlebot3_description_reduced_mesh
cd $TB3_MODELS
touch model.config
ln -s ../../meshes meshes 

echo $GAZEBO_MODEL_PATH
DIR=/root/gzweb
mkdir -p $DIR/http/client/assets/models
cd $DIR
./get_local_models.py $DIR/http/client/assets 1>/dev/null 2>/dev/null
./webify_models_v2.py $DIR/http/client/assets 1>/dev/null 2>/dev/null
mv $DIR/http/client/assets/aws* $DIR/http/client/assets/models/
npm start