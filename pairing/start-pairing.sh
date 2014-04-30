#!/bin/bash

tmux ls 2>&1 | grep -q 'failed to connect'
TMUX_RUNNING=$?

if [ -z "$1" ]; then
  echo "usage: $0 [session-name]"
  echo ""

  if [ $TMUX_RUNNING ]; then
    echo "Current sessions:"
    tmux ls -F ' - #{session_name}'
  else
    echo "No sessions currently running"
  fi
  echo ""

  echo "to disconnect from a session, use 'Ctrl+b, d'"

  exit
fi

SESSION_NAME=$1

tmux has -t $SESSION_NAME
HAS_SESSION=$?

if [ $HAS_SESSION = 0 ]; then
  echo "found session. Connecting..."
  tmux attach -t $SESSION_NAME
else
  echo "starting new session..."
  tmux -f .tmux-bare.conf new -s $SESSION_NAME "sudo -u matthijsgroen -i tmux"
fi

