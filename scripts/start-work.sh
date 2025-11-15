#!/bin/bash
SESSION_NAME="work"
PROJECT_PATH="/Users/backend-jkt/Workspace/sto-backend"

# --- Check if session exists and create it if it doesn't ---
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  # 1. Create session and Window 1: nvim in project directory
  tmux new-session -s $SESSION_NAME -n 'main' -d -c "$PROJECT_PATH"
  tmux send-keys -t $SESSION_NAME:main "nvim ." C-m

  # 2. Create Window 2: dev
  tmux new-window -n 'dev' -t $SESSION_NAME:2
  tmux send-keys -t $SESSION_NAME:2 "cd $PROJECT_PATH" C-m
  tmux send-keys -t $SESSION_NAME:2 "clear" C-m

  # 3. Create Window 3: DBUI
  tmux new-window -n 'DBUI' -t $SESSION_NAME:3
  tmux send-keys -t $SESSION_NAME:DBUI "cd $PROJECT_PATH" C-m

  NVIM_COMMAND='DBUI'
  tmux send-keys -t $SESSION_NAME:DBUI "nvim +\"${NVIM_COMMAND}\"" C-m

  # 4. Create Window 4: spotify
  tmux new-window -n 'spotify' -t $SESSION_NAME:4
  tmux send-keys -t $SESSION_NAME:spotify "spotify_player" C-m

  # 5. Select the starting window (dev - Window 2)
  tmux select-window -t $SESSION_NAME:2
fi

# Attach to the session
tmux attach -t $SESSION_NAME
