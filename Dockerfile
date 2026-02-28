ARG ROS_DISTRO=humble
ARG RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

FROM ros:${ROS_DISTRO}-ros-core AS build-env
ARG RMW_IMPLEMENTATION  
ARG ROS_DISTRO
ENV DEBIAN_FRONTEND=noninteractive \
    ROS_DISTRO=${ROS_DISTRO}\
    RMW_IMPLEMENTATION=${RMW_IMPLEMENTATION} \
    BUILD_HOME=/var/lib/build 
    #OUSTER_ROS_PATH=/opt/ros2_ws/src/ouster-ros


RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libeigen3-dev \
    libjsoncpp-dev \
    libspdlog-dev \
    libcurl4-openssl-dev \
    libpcap-dev \
    libopencv-dev \
    python3-rosdep \
    python3-colcon-common-extensions \
    ros-${ROS_DISTRO}-pcl-ros \
    ros-${ROS_DISTRO}-tf2-eigen \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-foxglove-bridge \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN mkdir -p /workspace/src

RUN rosdep init && rosdep update

COPY postcreatecommand.sh  /postcreatecommand.sh
RUN chmod +x /postcreatecommand.sh

# set entry point
ENTRYPOINT ["/postcreatecommand.sh"]
