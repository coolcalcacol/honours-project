ARG ROS_DISTRO=rolling

FROM ros:${ROS_DISTRO}-perception

ARG USERNAME=fstn_anon
ARG UID=1000
ARG GID=$UID

# Delete user if it exists in container (e.g Ubuntu Noble: ubuntu)
RUN if id -u $UID ; then userdel `id -un $UID` ; fi

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Install some dependencies packages
RUN apt-get update -q
RUN apt-get install -y --no-install-recommends \
    software-properties-common \
    python3-pip \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    sudo \
    vim \
    git \
    curl \
    wget \
    can-utils \
    kmod \
    iproute2 \
    iputils-ping \
    nano \
    xauth \
    python-is-python3

RUN apt-get upgrade -q -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create and switch to user
RUN groupadd -g $GID $USERNAME \
    && useradd -lm -u $UID -g $USERNAME -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME

# Create workspace so that user own this directory
RUN mkdir -p /home/$USERNAME/fstn_ws
WORKDIR /home/$USERNAME/fstn_ws

# Copy configuration files
RUN echo 'source /opt/ros/'$ROS_DISTRO'/setup.bash' >> /home/$USERNAME/.bashrc
RUN echo 'source /home/'$USERNAME'/fstn_ws/install/setup.bash' >> /home/$USERNAME/.bashrc

# Setup entrypoint
COPY ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
