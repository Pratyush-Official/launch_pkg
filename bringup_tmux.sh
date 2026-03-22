#!/bin/bash

SESSION=robocon

tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n bringup

tmux split-window -h          # pane 1
tmux split-window -v          # pane 2
tmux select-pane -t 0
tmux split-window -v          # pane 3
tmux select-pane -t 3
tmux split-window -v          # pane 4
tmux select-pane -t 4
tmux split-window -v          # pane 5
tmux select-pane -t 5
tmux split-window -v          # pane 6 

tmux select-layout tiled

# tmux send-keys -t 0 "echo '1' | sudo -S ros2 run dev_pi_communicate usb_init_node" C-m
# sleep 0.9

# tmux send-keys -t 1 "ros2 run ak_pkg ak_60_up" C-m
# sleep 0.9
# tmux send-keys -t 0 "ros2 run oakd_roi_detector detector_node" C-m
# sleep 0.9

tmux send-keys -t 1 "ros2 run dev_pi_communicate serial_bluepill" C-m
sleep 0.9

tmux send-keys -t 2 "ros2 run dev_pi_communicate serial_nucleo" C-m
sleep 0.9

# tmux send-keys -t 4 "ros2 run server odom_server_node" C-m
# sleep 0.9

tmux send-keys -t 3 "ros2 run server sick_server_node" C-m
sleep 0.9


# tmux send-keys -t 4 "ros2 run server yaw_server_node" C-m 
# sleep 0.9

tmux send-keys -t 5 "ros2 run martial_tree tree_ticker" C-m 
sleep 0.9



tmux attach -t $SESSION