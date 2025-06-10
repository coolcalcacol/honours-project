#!/bin/bash
set -e

# setup ros2 environment
source /opt/ros/"$ROS_DISTRO"/setup.bash --
source ~/fstn_ws/install/setup.bash --

# add sourcing to .bashrc
echo "source '/opt/ros/$ROS_DISTRO/setup.bash'" >> ~/.bashrc
echo "source '~/fstn_ws/install/setup.bash'" >> ~/.bashrc

exec "$@"
