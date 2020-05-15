# GZWeb Docker Example for RoboMaker Sample Application Local Development

(Note: this is experimental and will be updated frequently...)

This docker file will enable you to run AWS RoboMaker sample applications in gzweb with a docker container.

NOTE: For the code of these demos to connect to AWS, the docker container will need access to an AWS Access Key ID and Secret Key.

## Getting Started

### Build the Docker Image

Clone this repository and build the docker image:

```bash
cd ~
git clone https://github.com/jerwallace/aws-robomaker-sample-apps-gzweb.git
cd aws-robomaker-sample-apps-gzweb
docker build gzweb-docker/. -t gzweb:latest
docker build ros-docker/. -t rosapp:latest
sudo chmod +x run*
```

### Download an AWS RoboMaker Sample Application

If using the AWS RoboMaker Cloudwatch Sample Application, clone this repo:

```bash
git clone https://github.com/aws-robotics/aws-robomaker-sample-application-cloudwatch.git
```

You could also use your own ROS application. 

### Set your AWS Access Credentials as Environment Variables

To connect to your AWS account, remember to set the environment variables for your credentials.

```bash
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY>
```

## Running

To run gzweb, use the shell script provided `./run.sh`. Commands you can run are:

```bash
./run.sh --build-only # this command will use colcon in a container to build the sample app.
./run.sh --build # this command will use colcon in a container to build the sample app, then it will run the docker-compose up command in a silent shell
./run.sh -d # this command will run docker compose in detached mode (no shell output).
```

The default settings will work with the cloudwatch sample application, however feel free to modify them.

```bash
##======= CHANGE ME ========##
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
```

Once running, open your browser to `http://localhost:8080` to interact with **GZWeb**.
Also, if you add a rosbridge to your launch file, you can checkout **WebViz** locally here: `https://webviz.io/app`

If you are in Cloud9, the Preview App functionality will automatically map 8080 to 80. So, simply press "preview app.".
