#!/bin/bash

if [[ -z $1 ]]; then
  current=$(tmux display -p "#S")
  echo "usage: tmux-sendall SESSION WINDOW [COMMAND]"
  if [[ -n $current ]]; then
    echo "current session: $current"
  fi
  exit 1
else
  session="$1"
fi

if [[ -z $2 ]]; then
  echo "Error: You must specify a window index!"
  exit 1
else
  window="$2"
fi

if [[ -n $3 ]]; then
  message="$3"
else
  read -p "send cmd to session $session, window $window$ " message
  if [[ -z $message ]]; then exit 1; fi
fi

function sendwindow() {
  # $1=target, $2=command
  tmux setw -t "$1" synchronize-panes
  tmux send-keys -t "$1" "$2"
  tmux send-keys -t "$1" "Enter"
  tmux setw -t "$1" synchronize-panes off
}

# Target only the specified window (not the whole session)
sendwindow "$session:$window" "$message"
