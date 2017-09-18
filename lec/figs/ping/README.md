# MPI ping-pong

The MPI ping-pong test involves sending packets of various sizes from
node zero to some other MPI process.  The usage is

    ./ping.x p ntrials

where `p` is the ID of the second processor and `ntrials` is the number
of back-and-forth messages to use for timing.

As it is currently set up, running `make` will build the program and launch a
ping-pong tests.  Running `make run2` will run another ping-pong test.  The
first test runs on whichever among the CS class node slots is available; this
will often, but not always, result in the two MPI processes falling on the same
node.  The second test forces the two processes to be on different nodes.  If
the cluster is not too heavily loaded, you should be able to see a significant
difference between intra-node and inter-node communication latencies and
bandwidths this way.

