---
title: Cluster information
layout: main
---

The primary computing platform will be an instructional cluster (the
[Totient][totient] cluster) with fifteen [Xeon Phi 5110P][phi-spec]
boards hosted in eight 12-core compute nodes consisting of
[Intel Xeon E5-2620 v3][xeon-spec] processors and 32 GB RAM per node.
Node `totient-02` has one Phi board; the other compute nodes have two.
The head node is *not* as powerful as the compute nodes; please
refrain from using it to run computationally intensive jobs.
Unless otherwise stated, homework and projects should be tested and
timed on these machines.

The cluster runs [RedHat Enterprise Linux 6.7 (Santiago)](rhel67).
The system base compilers are a bit old, but we plan to install the
[Developer Toolset][devtools] with more recent versions of the
compiler as well as some utilities.

Intel generously donated the Xeon Phi boards and funded the purchase
of the host machines, which were provided with deep matching discounts
by Dell.

[totient]: https://en.wikipedia.org/wiki/Euler%27s_totient_function
[phi-spec]: http://ark.intel.com/products/71992/Intel-Xeon-Phi-Coprocessor-5110P-8GB-1_053-GHz-60-core
[xeon-spec]: http://ark.intel.com/products/83352/Intel-Xeon-Processor-E5-2620-v3-15M-Cache-2_40-GHz
[rhel67]: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/index.html
[devtools]: https://access.redhat.com/documentation/en-US/Red_Hat_Developer_Toolset/3/index.html

## Accounts and login

In order to obtain access to the cluster, you will need to be enrolled
in the class.  If you want access as an informal auditor, you will
need to contact me (David Bindel) regarding access; please make sure
you send your netid in any such email.  The Cornell information
systems don't all talk to each other, so please also drop me a note if
you are adding or dropping the course after the first week or so, so
that we can keep the account information up to date.

### Basic login information

The cluster head node is `en-cs-totient-01.coecis.cornell.edu`.
It is accessible via SSH.  You will need to be on the campus network
(or connected via the
[campus VPN](http://www.it.cornell.edu/services/vpn/)) in order to
access this machine.  The cluster login information is synchronized
with the campus Active Directory, so your login name is your Cornell
netid and your password is the associated password.

### Passwordless login

I recommend setting up SSH key-based authentication so that you don't
have to type your password every time you log in.  From your private
machine (e.g. a laptop computer), you can generate an SSH key pair;
see, for example
[this tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server).
How to generate an SSH key and register it with an agent varies a bit
depending on your operating system and SSH client; my recommendation
is

 - If you are on Mac OS X, the native SSH client can use the system
   keychain directly.  To add your private key, simply use the command

       ssh-add -K /path/of/private/key

 - If you are on a Linux variant, or if you are using Cygwin under Windows, I
   recommend using the [keychain](http://linux.die.net/man/1/keychain)
   program. If you are running GNOME, you likely have [GNOME
   Keyring](https://en.wikipedia.org/wiki/GNOME_Keyring) already installed on
   your system and do not need keychain. If are you running KDE, you likely have
   [KWallet](https://en.wikipedia.org/wiki/KWallet), a similar program. If you
   do not have these, you can still use keychain.

 - Under Windows, [PuTTY](www.putty.org) seems to be the most common
   SSH client (unless you are using the SSH client under Cygwin).
   One set of directions for setting up passwordless ssh is
   [here](https://www.digitalocean.com/community/tutorials/how-to-create-ssh-keys-with-putty-to-connect-to-a-vps).
   I have little personal experience with this, so feel free to put
   in a better link!

Once you have generated an SSH key, copy the public part of the key to
`.ssh/authorized_keys` and change the permission by typing
`chmod 600 ~/.ssh/authorized_keys` at the command prompt on the head node.
Then you should be set to go.

### Public keys, agent forwarding, and GitHub

You can use SSH public keys for write access to your GitHub
repository (and likewise with BitBucket, GitLab, and most other
hosted solutions).  GitHub has a useful
[five-step walkthrough](https://help.github.com/articles/generating-ssh-keys/)
for setting this up.

If you want to use a single SSH key on your laptop to also access
your repositories from the class cluster, you may want to
log in with
[agent forwarding](https://developer.github.com/guides/using-ssh-agent-forwarding/).
In my case, I have the following lines in my laptop `.ssh/config` file
to simplify logging into the cluster with agent forwarding:

    Host totient
    Hostname en-cs-totient-01.coecis.cornell.edu
    User dsb253
    ForwardAgent yes

## Submitting batch jobs

For simple compiling, editing, and testing, you can work on the
Totient head node.  For timing runs, you will want to submit jobs to
the batch queue system.  Batch jobs on the Totient cluster are managed by the
[TORQUE](http://www.adaptivecomputing.com/products/open-source/torque/)
resource manager.  To run a batch job, you will need to create a PBS
script; for example, the 
[following script](https://github.com/cornell-cs5220-f15/demo/blob/master/hostname.pbs)
runs the `hostname` command
on a single machine, sending an email to my address if anything went
wrong:

    #!/bin/sh
    
    #PBS -N hostname
    #PBS -j oe
    #PBS -M your_net_id@cornell.edu
    
    hostname

To submit this, I would run `qsub hostname.pbs`; and I can see the status
(queued, running, exiting, completed) by running `qstat`.  On
completion, I would have a file called `hostname.o35` (or similar)
with the output of the script.

Batch scripts *must* be script files, but they don't have to use the
standard Bourne or BASH shells.  If you prefer, you can use csh, zsh,
or Python!  Just change the executable mentioned in the first line.
This can be useful when doing things that are more complex than
running a single executable, such as running parameter studies.

## Modules

High-performance computing installations often use
[environment modules](http://modules.sourceforge.net/) to manage the
(sometimes conflicting) software requirements for different
applications and environments.  For example, different modules may be
available for different implementations of MPI, different compilers,
or different versions of major libraries.

### Using environment modules

The basic module commands are:

- `module avail`: list available modules
- `module list`: list loaded modules
- `module load foo`: load module `foo`
- `module unload foo`: unload module `foo`

To load a standard set of modules for the class, do

    module load cs5220

This will load the `devtoolset`, `utils`, `psxe`, and `anaconda` packages.

### General system tools

The default tools on the system are rather old.  The `devtoolset` and
`utils` packages are there to get newer versions of the most critical
tools (e.g. compiler support).

- `cs5220`: Load a standard set of modules for the class
- `utils`: Up-to-date `git`, `binutils`, and various other utilities
- `devtoolset`: [RedHat devtoolset-3 developer utilities][devtoolset]

[devtoolset]: https://www.softwarecollections.org/en/scls/rhscl/devtoolset-3/

### Python

The system Python installation is Python 2.6.  We have vanilla Python
2.7 and 3.4.3 installs, but for anything serious, I recommend using
the Anaconda Python distribution (which comes with Python 2.7 and
Python 3.4 with a full NumPy/SciPy stack, Matplotlib, and many other
utilities).

- `anaconda`: [Anaconda Scientific Python distribution][anaconda]
- `python/2.7`: Generic Python build (version 2.7)
- `python/3.4.3`: Generic Python build (version 3.4.3)

[anaconda]: https://store.continuum.io/cshop/anaconda/

### Compilers and such

In addition to the system GCC (4.4.7) and the `devtoolset-3` GCC
(4.9.2), we have the Intel compilers and Clang/Clang++ available.
We also have GCC 5.2.0, though I didn't build that much for it.

- `psxe/2015`: [Intel Parallel Studio XE 2015 (Intel compilers, VTune, etc)][psxe]
- `llvm/3.7.0`: [LLVM 3.7][llvm] and [ISPC][ispc]
- `gcc/5.2.0`: [GCC 5.2.0][gcc5]
- `upc/2.20.2`: [Berkeley Unified Parallel C][upc]

[psxe]: https://software.intel.com/en-us/intel-parallel-studio-xe
[gcc5]: https://gcc.gnu.org/gcc-5/
[llvm]: http://llvm.org/
[ispc]: https://ispc.github.io/
[upc]: http://upc.lbl.gov/

### C++ tools

Boost is a standard set of tools for C++.  Armadillo and Eigen are
linear algebra libraries in C++; if you have no preference between
the two, I recommend Armadillo.

- `boost`: [Boost C++ library][boost]
- `armadillo`: [Armadillo C++ numerical library][armadillo]
- `eigen`: [Eigen][eigen]

[boost]: http://www.boost.org/
[armadillo]: http://arma.sourceforge.net/
[eigen]: http://eigen.tuxfamily.org/index.php?title=Main_Page

### Numerical libraries

We're going to see BLAS and LAPACK early in the semester, and also
FFTW and perhaps SuiteSparse.  We likely won't say anything in
particular about GSL, but it's there if you want it.

- `openblas`: [OpenBLAS][openblas]
- `lapack`: [LAPACK][lapack]
- `fftw`: [Fastest Fourier Transform in the West][fftw]
- `suitesparse`: [SuiteSparse sparse linear solvers][suitesparse]
- `gsl`: [GNU Scientific Library][gsl]

[openblas]: http://www.openblas.net/
[lapack]: http://www.netlib.org/lapack/
[fftw]: http://www.fftw.org/
[gsl]: http://www.gnu.org/software/gsl/
[suitesparse]: http://faculty.cse.tamu.edu/davis/suitesparse.html

### Storage

HDF5 is one of the major standards for storing large volumes of
scientific data.  NetCDF plays in the same space as HDF5, and
MatI/O is a set of convenience wrappers that's kind of nice if
you want to read and write MATLAB files.

- `hdf5`: [HDF5: Heirarchical Data Format library][hdf5]
- `netcdf`: [NetCDF: Network Common Data Format library][netcdf]
- `matio`: [Matrix I/O library][matio]

[hdf5]: https://www.hdfgroup.org/HDF5/
[netcdf]: http://www.unidata.ucar.edu/software/netcdf/
[matio]: http://sourceforge.net/projects/matio/

### Parallel support

We have multiple OpenMPI implementations installed, as well as Intel
MPI.  If you're going to use OpenMPI, I recommend one of the OpenMPI
1.10.0 builds.

- `openmpi`: [OpenMPI][openmpi]
- `torque`: [Torque batch queue manager][torque]

[openmpi]: http://www.open-mpi.org/
[torque]: http://www.adaptivecomputing.com/products/open-source/torque/
