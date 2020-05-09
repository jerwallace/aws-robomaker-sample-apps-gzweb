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

If you want to see the console output, run `./launch_gzweb_with_shell.sh`, otherwise run `./launch_gzweb.sh`.

Open your browser to `http://localhost:8080`

If you are in Cloud9, the Preview App functionality will automatically map 8080 to 80. So, simply press "preview app.".
