#!/bin/bash

SESSION=forest
SOURCE="source ~/arrobo_ws/install/setup.bash"

tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n bringup

# Create 5 panes total
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -t 2
tmux split-window -v

tmux select-layout tiled

tmux send-keys -t 0 "$SOURCE && ros2 run server sick_server_node" C-m
sleep 0.9

tmux send-keys -t 1 "$SOURCE && ros2 run server yaw_server_node" C-m
sleep 0.9

tmux send-keys -t 2 "$SOURCE && ros2 run serial_bridge_2026 serial_bridge_node" C-m
sleep 0.9

tmux send-keys -t 3 "$SOURCE && ros2 run serial_bridge_2026 cmd_multiplexer" C-m
sleep 0.9

tmux send-keys -t 4 "$SOURCE && ros2 run serial_bridge_2026 process_odom" C-m
sleep 0.9

tmux attach -t $SESSION
