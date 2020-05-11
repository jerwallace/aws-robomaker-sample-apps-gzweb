#!/bin/bash

##======= CHANGE ME (OR COMMENT THIS SECTION OUT AND USE ENV VARS) ========##
HOME=~/aws-robomaker-sample-apps-gzweb
WORKSPACE_DIR=aws-robomaker-sample-application-cloudwatch
WORLDS=(aws_robomaker_bookstore_world aws_robomaker_small_house_world)
export GZWEB_DOCKER_IMAGE=gzweb:latest
export ROS_DOCKER_IMAGE=rosapp:latest
export ROS_PACKAGE_SIM=cloudwatch_simulation
export ROS_LAUNCH_FILE_SIM=bookstore_turtlebot_navigation.launch
export ROS_PACKAGE_ROBOT=cloudwatch_robot
export ROS_LAUNCH_FILE_ROBOT=monitoring.launch 
export TURTLEBOT3_MODEL=waffle_pi
export ROBOT_APP_INSTALL=$HOME/$WORKSPACE_DIR/robot_ws
export SIM_APP_INSTALL=$HOME/$WORKSPACE_DIR/simulation_ws
##==========================##
shell=false

build() {
    docker run -v $SIM_APP_INSTALL:/simulation_ws $ROS_DOCKER_IMAGE bash -c "cd /simulation_ws && rosws update && rosdep install --from-paths src --ignore-src -r -y && colcon build"
    docker run -v $ROBOT_APP_INSTALL:/robot_ws $ROS_DOCKER_IMAGE bash -c "cd /robot_ws && rosws update && rosdep install --from-paths src --ignore-src -r -y && colcon build"
    python fixme.py $SIM_APP_INSTALL/install
}

create_model_path() {
    # Add the paths to your model files for each world that is included in your ROS app.
    for i in "${WORLDS[@]}"
    do
    : 
        model_path=$model_path:/simulation_ws/install/$i/share/$i/models/
    done
        model_path=$model_path:/simulation_ws/install/turtlebot3_description_reduced_mesh/share/turtlebot3_description_reduced_mesh/models/
}

while test $# -gt 0
do
    case "$1" in
        --build-only) 
            build 
            exit
            ;;
        --build) 
            build
            ;;
        --shell) 
            shell=true
            ;;
        --*) echo "Bad option provided: $1"
            ;;
        *) echo "Argument does not exist: $1"
            ;;
    esac
    shift
done

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "Please set your environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to run these apps."
    exit 
fi

# Build the code and ensure XML is valid for any visual DAE files in the source.
if [[ -d "$ROBOT_APP_INSTALL" ]] && [[ -d "$SIM_APP_INSTALL" ]]; then

    create_model_path
    export SIM_APP_MODEL_PATHS=$model_path

    if $shell ; then
        echo "Starting apps with shell..."
        docker-compose up
    else
        echo "Starting apps without shell..."
        docker-compose up -d
    fi
else
    echo "No built applications to run. Try again with --build."
fi
