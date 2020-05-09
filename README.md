# GZWeb Docker Support for RoboMaker Sample Applications

(Note: this is experimental...)

This docker file will enable you to run AWS RoboMaker sample applications in gzweb with a docker container.

NOTE: For the code of these demos to connect to AWS, the docker container will need access to an AWS Access Key ID and Secret Key.

## Getting Started

### Download an AWS RoboMaker Sample Application

If using the AWS RoboMaker Cloudwatch Sample Application, clone this repo:

```bash
cd ~
git clone https://github.com/aws-robotics/aws-robomaker-sample-application-cloudwatch.git
```

You could also use your own ROS application. 

### Build the Docker Image

Clone this repository and build the docker image:

```bash
cd ~
git clone https://github.com/jerwallace/aws-robomaker-sample-apps-gzweb.git
cd aws-robomaker-sample-apps-gzweb
docker build ./ -t gzweb:latest
sudo chmod +x launch_gzweb*
```

## Running

To run gzweb, use the shell script provided `./launch_gzweb.sh`. You can attach a shell and run gzweb manually in the container by running `./launch_gzweb.sh shell`

The default settings will work with the cloudwatch sample application, however feel free to modify them.

```bash
##======= CHANGE ME ========##
HOME=~
WORKSPACE_DIR=aws-robomaker-sample-application-cloudwatch
WORLDS=(aws_robomaker_bookstore_world aws_robomaker_small_house_world)
DOCKER_IMAGE=gzweb:latest
ROS_PACKAGE_SIM=cloudwatch_simulation
ROS_LAUNCH_FILE_SIM=test_world.launch
ROS_PACKAGE_ROBOT=cloudwatch_robot
ROS_LAUNCH_FILE_ROBOT=monitoring.launch 
TURTLEBOT3_MODEL=waffle_pi
ROBOT_APP_INSTALL=$HOME/$WORKSPACE_DIR/robot_ws/
SIM_APP_INSTALL=$HOME/$WORKSPACE_DIR/simulation_ws/
##==========================##
```

Once running, open your browser to `http://localhost:8080`

If you are in Cloud9, the Preview App functionality will automatically map 8080 to 80. So, simply press "preview app.".
