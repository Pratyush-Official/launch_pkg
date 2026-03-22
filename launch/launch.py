from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package="dev_pi_communicate",
            executable="serial_bluepill",
            name="bluepill_node",
            output="screen"
        ),
        Node(
            package="dev_pi_communicate",
            executable="serial_nucleo",
            name="nucleo_node",
            output="screen"
        ),
        Node(
            package="server",
            executable="pid_server_node",
            name="pid_node",
            output="screen"
        ),
        Node(
            package="martial_tree",
            executable="tree_ticker",
            name="treetick_node",
            output="screen"
        ),

        Node(
            package="oakd_roi_detector",
            executable="ak_60_up",
            name="ak_node",
            output="screen"
        ),

    ])
