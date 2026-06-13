#!/bin/bash

SESSION="forest"
SOURCE="source ~/arrobo_ws/install/setup.bash"

# Kill existing session if it's running
tmux kill-session -t $SESSION 2>/dev/null

# 1. Start session and capture the first pane ID
P0=$(tmux new-session -d -s $SESSION -n bringup -P -F '#{pane_id}')

# 2. Generate the layout and capture every single unique pane ID explicitly
P1=$(tmux split-window -h -t $P0 -P -F '#{pane_id}')

tmux select-pane -t $P0
P2=$(tmux split-window -v -t $P0 -P -F '#{pane_id}')
P3=$(tmux split-window -v -t $P2 -P -F '#{pane_id}')

tmux select-pane -t $P1
P4=$(tmux split-window -v -t $P1 -P -F '#{pane_id}')
P5=$(tmux split-window -v -t $P4 -P -F '#{pane_id}')

# Now balance them into a perfect grid safely
tmux select-layout -t $SESSION:0 tiled

# ─────────────────────────────────────────────────────────────────
#  SEQUENTIAL NODE BRINGUP (Using explicit IDs)
# ─────────────────────────────────────────────────────────────────

# Pane 0: sick_server_node
tmux send-keys -t $P0 "$SOURCE && ros2 run server sick_server_node" C-m
sleep 0.9

# Pane 1: odom_server_node
tmux send-keys -t $P1 "$SOURCE && ros2 run server odom_server_node" C-m
sleep 0.9

# Pane 2: process_odom
tmux send-keys -t $P2 "$SOURCE && ros2 run serial_bridge_2026 process_odom" C-m
sleep 0.9

# Pane 3: cmd_multiplexer
tmux send-keys -t $P3 "$SOURCE && ros2 run serial_bridge_2026 cmd_multiplexer" C-m
sleep 0.9

# Pane 4: serial_bridge_node
tmux send-keys -t $P4 "$SOURCE && ros2 run serial_bridge_2026 serial_bridge_node" C-m
sleep 0.9

tmux send-keys -t $P5 "$SOURCE && ros2 run serial_bridge_2026 gpio_node" C-m
sleep 0.9

# Attach to the session to monitor everything
tmux attach -t $SESSION