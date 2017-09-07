#!/bin/bash

if [ -z "$1" ] ; then
  RFILE=./repo.txt
else
  RFILE=$1
fi

REPO=$(head -n 1 $RFILE)
if echo $REPO | grep "^http" ; then
  echo "Looks like an HTTPS URL; convert"
  REPO=`echo $REPO | sed 's/https*:[/][/]/git@/' | sed 's/[/]/:/'`
fi
echo "Fetch from $REPO"
ssh-agent bash -c "ssh-add $RFILE ; git clone $REPO"
