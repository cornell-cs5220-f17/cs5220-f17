/* Based on:
 *
 *   www.cs.berkeley.edu/~richie/bebop/notes/matmul/files/membench/
 *
 * This version uses the OpenMP omp_get_wtime() routine -- even though
 * we are doing nothing parallel.  Note that if you want to try this
 * on an OS X box, you will need to use GCC (or llvm-gcc), since the
 * Clang compiler still doesn't support OpenMP out of box.
 */

#include <stdio.h>
#include <omp.h>

#define SAMPLE    10
#define CACHE_MIN (1024)
#define CACHE_MAX (16*1024*1024)
#define RTIME     0.1

int x[CACHE_MAX];

int main(int argc, char** argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage: membench result.csv\n");
        return 1;
    }
    
    FILE* fp = fopen(argv[1], "w");
    if (fp == NULL) {
        fprintf(stderr, "Could not open \"%s\" for output\n");
        return 2;
    }
        
    /* Print CSV file header */
    fprintf(fp, "size,stride,ns\n");  

    /* Run the timing experiments */
    for (long csize = CACHE_MIN; csize <= CACHE_MAX; csize *= 2){
        for (int stride = 1; stride <= csize/2; stride *= 2){
            double sec0 = 0;
            double sec1 = 0;
            int limit = csize-stride+1;
            
            /* Time the loop with strided access + loop overhead */
            int steps = 0;
            double start = omp_get_wtime();
            do {
                for (int i = SAMPLE*stride; i != 0; i--)
                    for (int index = 0; index < limit; index += stride)
                        x[index]++;
                steps++;
                sec0 = omp_get_wtime()-start;
            } while (sec0 < RTIME);

            /* Try to time just the overheads */
            int tsteps=0;
            int temp=0;
            start = omp_get_wtime();
            do {
                for (int i = SAMPLE*stride; i != 0; i--)
                    for (int index = 0; index < limit; index += stride)
                        temp += index;
                tsteps++;
                sec1 = omp_get_wtime()-start;
            } while (tsteps < steps);
            
            /* Report on the average time per read/write */
            double sec            = sec0 - sec1;
            double ns_per_step    = (sec*1.0e9)/steps;
            double reads_per_step = SAMPLE*stride*((limit-1.0)/stride+1.0);
            fprintf(fp, "%d,%d,%f\n",
                    csize*sizeof(int),
                    stride*sizeof(int), 
                    ns_per_step/reads_per_step);
        }
    }

    fclose(fp);
    return 0;
}
