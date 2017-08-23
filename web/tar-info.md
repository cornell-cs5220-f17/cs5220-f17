---
title:      Working with tarballs
layout:     main
---

We *strongly* encourage you to keep your code in a (private) hosted
Git repository.  Nonetheless, it is also useful to know how to create
and move around "tarball" files.  A tarball is a set of files packaged
together into a single file, then compressed using the gzip
compression program.  "Tar" is short for "tape archive," which tells
you something about how long this particular mode of packaging files
has been around!  Most Unix software on the net is distributed as
tarballs, and tarballs are also useful for moving around large binary
files from place to place.

To create a tarball of all the files in the directory `mystuff`,
type

    tar czf mystuff.tgz mystuff
    
and to unpack the files, type

    tar xzf mystuff.tgz

The mess of letters after the `tar` command tells the program what it
is supposed to do; they have the following meanings:

  - **f** filename: Specify the archive file name
  - **c**: Create an archive file
  - **x**: Extract an archive file
  - **z**: Put an archive through `gzip`
  - **t**: Get a table of contents for the archive
  - **v**: Be verbose and tell me exactly what is happening

If you create a tarball on the cluster, you may want to use it to get
a local copy on your laptop or home desktop.  For this purpose, we
recommend you use SFTP to move the files back and forth.  If you are
using a Linux machine or a Mac, you can open a terminal window and
manipulate tarballs just as you would on the cluster.  If you are on a
Windows machine, you might be interested in using the
[Cygwin](https://www.cygwin.com/) package, which provides a wide
variety of Unix-style tools.
