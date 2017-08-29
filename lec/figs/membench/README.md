# membench

This is a simple memory benchmark; see, e.g.,
["Empirical Evaluation of the CRAY-T3D: A Compiler Perspective"][1]
from ISCA 1995.  The `membench` C code basically times

    for array A of length L from 4KB to 8MB by 2x
      for stride s  from 4 bytes to L/2 by 2x
        time the following loop
        for i = 0 to L by s
          load A[i]

The raw times can be plotted as a set of lines or as a heat map
(I find the latter easier to process visually).

If you are running membench on the totient cluster, you will want
to obtain the timings by running `qsub membench.pbs` rather than
by running the `membench` executable on the head node.  The head
node and the compute nodes have rather different performance characteristics.

[1]: http://pages.cs.wisc.edu/~remzi/Postscript/isca95.pdf
