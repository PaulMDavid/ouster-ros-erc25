#!/bin/bash
set -e
source /opt/ros/${ROS_DISTRO}/setup.bash
cd /workspace
colcon build --merge-install
source /workspace/install/setup.bash

# Create driver_params.yaml in correct merge-install location
mkdir -p /workspace/install/share/ouster_ros/config/
cat > /workspace/install/share/ouster_ros/config/driver_params.yaml << 'EOF'
ouster/os_driver:
  ros__parameters:
    sensor_hostname: '169.254.61.114'
    lidar_mode: '1024x10'
    timestamp_mode: 'TIME_FROM_ROS_TIME'
    azimuth_window_start: 40000
    azimuth_window_end: 320000
    min_range: 0.3
    organized: true
    destagger: true
    use_system_default_qos: true
EOF

exec "$@"
