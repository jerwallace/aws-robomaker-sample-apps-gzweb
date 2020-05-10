# This is an auto generated Dockerfile for gazebo:gzweb11
# generated from docker_images/create_gzweb_image.Dockerfile.em
FROM gazebo:libgazebo9-bionic

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    build-essential \
    cmake \
    imagemagick \
    libboost-all-dev \
    libgts-dev \
    libjansson-dev \
    libtinyxml-dev \
    mercurial \
    pkg-config \
    psmisc \
    xvfb \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_8.x  | bash -
RUN apt-get update && apt-get -y install nodejs

# install gazebo packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    libgazebo9-dev=9.13.0-1* \
    && rm -rf /var/lib/apt/lists/*

# clone gzweb
ENV GZWEB_WS /root/gzweb
RUN hg clone https://bitbucket.org/osrf/gzweb $GZWEB_WS
WORKDIR $GZWEB_WS

# build gzweb
RUN hg up default \
    && xvfb-run -s "-screen 0 1280x1024x24" ./deploy.sh -m

# setup environment
EXPOSE 8080
EXPOSE 7681
EXPOSE 9090

RUN apt update && apt install python-tornado python-bson -y
ADD start.sh /
RUN chmod +x /start.sh

#CMD ["/start.sh"]

#CMD /root/gzweb/deploy.sh -m local -t && source /app/setup.bash && roslaunch $ROS_PACKAGE $ROS_LAUNCH_FILE & npm start

# run gzserver and gzweb
# xvfb-run -s "-screen 0 1280x1024x24" gzserver --verbose &
# CMD npm start
# docker run --network="host" -v $ROS_INSTALL/install:/app -e TURTLEBOT3_MODEL=waffle_pi -e ROS_PACKAGE=cloudwatch_simulation -e ROS_LAUNCH_FILE=test_world.launch GAZEBO_MODEL_PATH=/usr/share/gazebo-9/models:/opt/ros/melodic/share/turtlebot3_gazebo/models:/app/aws_robomaker_bookstore_world/share/aws_robomaker_bookstore_world --privileged -it gzweb:latest /bin/bash  
