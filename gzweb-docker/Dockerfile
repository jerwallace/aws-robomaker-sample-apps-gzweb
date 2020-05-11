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

RUN apt-get update && apt-get install python-tornado python-bson -y
ADD start.sh /
RUN chmod +x /start.sh