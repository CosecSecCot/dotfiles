#!/usr/bin/env bash

# if [[ $# -eq 1 ]]; then
#     selected=$1

if [[ $# -eq 1 ]]; then
    if [[ $1 == '.' ]]; then
        selected=$(pwd)
    elif [[ $1 == '..' ]]; then
        selected=$(dirname $(pwd))
    else
        selected=$1
    fi
else
    selected=$(find ~ -maxdepth 3 -type d| fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . ' ')

# Check if tmux is running
# if ! pgrep -x "tmux" > /dev/null; then
#     echo "tmux is not running"
# else
#     echo "tmux is running"
# fi

# if [ -n "$TMUX" ]; then
#     echo "Inside a tmux session"
# else
#     echo "Not inside a tmux session"
# fi

# if ! tmux has-session -t=$selected_name 2> /dev/null; then
#     tmux new-session -ds $selected_name -c $selected -A -D
# fi

# tmux switch-client -t $selected_name

if [ -n "$TMUX" ]; then
    # If the session with the selected name doesn't exist, create a detached session
    if ! tmux has-session -t=$selected_name 2>/dev/null; then
        tmux new-session -ds $selected_name -c $selected -A -D
    fi

    # Switch to the selected session
    tmux switch-client -t $selected_name
else
    # If tmux is not running, start a new session
    if ! pgrep -x "tmux" >/dev/null; then
        tmux new-session -s $selected_name -c $selected -A -D
    else
        # If tmux is running but you're not in a session, create a new session
        # or attach to an existing one
        if ! tmux has-session -t=$selected_name 2>/dev/null; then
            tmux new-session -s $selected_name -c $selected -A -D
        else
            tmux new-session -ds $selected_name -c $selected -A -D
            tmux switch-client -t $selected_name
        fi
    fi
fi
