#!/bin/bash

##======= CHANGE ME (OR COMMENT THIS SECTION OUT AND USE ENV VARS) ========##
SAMPLE_APP=aws-robomaker-sample-application-cloudwatch
WORLDS=(aws_robomaker_bookstore_world aws_robomaker_small_house_world)
DOCKER_IMAGE=gzweb:latest
ROS_PACKAGE_SIM=cloudwatch_simulation
ROS_LAUNCH_FILE_SIM=test_world.launch
ROS_PACKAGE_ROBOT=cloudwatch_robot
ROS_LAUNCH_FILE_ROBOT=monitoring.launch 
TURTLEBOT3_MODEL=waffle_pi
##==========================##

# Paths to the two ROS applications that will run in the container.
ROBOT_APP_INSTALL=~/$SAMPLE_APP/robot_ws/
SIM_APP_INSTALL=~/$SAMPLE_APP/simulation_ws/

# Get OS... 
case "$(uname -s)" in
    Linux*)     OPERATING_SYSTEM=Linux;;
    Darwin*)    OPERATING_SYSTEM=Mac;;
    CYGWIN*)    OPERATING_SYSTEM=Cygwin;;
    *)          OPERATING_SYSTEM="${unameOut}"
esac

# Add the paths to your model files for each world that is included in your ROS app.
for i in "${WORLDS[@]}"
do
   : 
   SIM_APP_MODEL_PATHS=$SIM_APP_MODEL_PATHS:/sim_app/$i/share/$i/models/
done
SIM_APP_MODEL_PATHS=$SIM_APP_MODEL_PATHS:/sim_app/turtlebot3_description_reduced_mesh/share/turtlebot3_description_reduced_mesh/models/

# Build the code and ensure XML is valid for any visual DAE files in the source.
if [ ${OPERATING_SYSTEM} == "Linux" ]; then
    python fixme.py $SIM_APP_INSTALL/src
    cd $ROBOT_APP_INSTALL && colcon build
    cd $SIM_APP_INSTALL && colcon build
elif [[ -d "$ROBOT_APP_INSTALL" ]] && [[ -d "$SIM_APP_INSTALL" ]]; then
    echo "Running on a $OPERATING_SYSTEM machine with no built applications. Please use a colcon docker image to build the ROS application before running this script."
    exit
else
    python fixme.py $SIM_APP_INSTALL/install
fi

# Run the container with a shell. Once in the shell, simply run "/start.sh"
if [ "$1" == "shell" ]; then
    RUN_COMMAND="--privileged -it $DOCKER_IMAGE /bin/bash"
else
    RUN_COMMAND="--privileged -d $DOCKER_IMAGE /start.sh"
fi

docker run \
--network="host" \
-v $ROBOT_APP_INSTALL/install:/robot_app \
-v $SIM_APP_INSTALL/install:/sim_app \
-e TURTLEBOT3_MODEL=$TURTLEBOT3_MODEL \
-e ROS_PACKAGE_SIM=$ROS_PACKAGE_SIM \
-e ROS_LAUNCH_FILE_SIM=$ROS_LAUNCH_FILE_SIM \
-e ROS_PACKAGE_ROBOT=$ROS_PACKAGE_ROBOT \
-e ROS_LAUNCH_FILE_ROBOT=$ROS_LAUNCH_FILE_ROBOT \
-e GAZEBO_MODEL_PATH=:$SIM_APP_MODEL_PATHS \
$RUN_COMMAND