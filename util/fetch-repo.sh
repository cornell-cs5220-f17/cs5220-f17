#!/bin/bash

if [ -z "$1" ] ; then
  RFILE=./repo.txt
else
  RFILE=$1
fi

REPO=$(head -n 1 $RFILE)
GIT_SSH_COMMAND="ssh -i $RFILE" git clone $REPO
