#!/bin/bash

if [ -z "$1" ] ; then
  RFILE=./repo.txt
else
  RFILE=$1
fi

REPO=$(head -n 1 $RFILE)
ssh-agent bash -c "ssh-add $RFILE ; git clone $REPO"
