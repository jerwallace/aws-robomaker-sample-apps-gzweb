#!/bin/bash
echo $GAZEBO_MODEL_PATH
DIR=/root/gzweb
mkdir -p $DIR/http/client/assets/models
cd $DIR
./get_local_models.py $DIR/http/client/assets
./webify_models_v2.py $DIR/http/client/assets
mv $DIR/http/client/assets/aws* $DIR/http/client/assets/models/
npm start