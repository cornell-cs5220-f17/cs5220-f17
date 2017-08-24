#!/bin/bash

# Choose a remote branch (default is origin)
if [ -z "$1" ] ; then
  echo "No branch given, default is origin"
  BRANCH=origin
else
  BRANCH=$1
fi

# Create a .ssh/submit-key for remote access
GITROOT=`git rev-parse --show-toplevel`
if [ -f $GITROOT/.ssh/submit-key ] ; then
  echo "Using existing submission key."
else 
  mkdir -p $GITROOT/.ssh
  ssh-keygen \
	-t rsa -b 4096 \
	-C "$(whoami)@cornell.edu" \
	-N "" \
	-f $GITROOT/.ssh/submit-key
fi

# Create (or re-create) a submission tag and sync with origin
git tag -f submission
RTAG=`git ls-remote $BRANCH refs/tags/submission`
if [ -z "$RTAG" ] ; then
  echo "Creating submission tag at $BRANCH"
else
  echo "Destroy original submission tag at $BRANCH"
  git push --delete $BRANCH submission
fi
git push $BRANCH master --tags

# Create the repo.txt file
git remote get-url $BRANCH > repo.txt
cat $GITROOT/.ssh/submit-key >> repo.txt

cat <<EOF

====
Please add the following public deployment key to your repo:
EOF
cat $GITROOT/.ssh/submit-key.pub
