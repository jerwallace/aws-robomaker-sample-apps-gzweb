#!/bin/bash

TB3_MODELS=/app/turtlebot3_description_reduced_mesh/share/turtlebot3_description_reduced_mesh/models/turtlebot3_description_reduced_mesh
cd models/turtlebot3_description_reduced_mesh/
mkdir -p $TB3_MODELS
cd $TB3_MODELS
touch model.config
ln -s ../../meshes meshes 

DIR=/root/gzweb
mkdir -p $DIR/http/client/assets/models
cd $DIR
./get_local_models.py $DIR/http/client/assets
./webify_models_v2.py $DIR/http/client/assets
mv $DIR/http/client/assets/aws* $DIR/http/client/assets/models/
npm start