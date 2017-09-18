#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void ping(char* buf, int n, int ntrials, int p)
{
    for (int i = 0; i < ntrials; ++i) {
        MPI_Send(buf, n, MPI_CHAR, p, 0, MPI_COMM_WORLD);
        MPI_Recv(buf, n, MPI_CHAR, p, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }
}


void pong(char* buf, int n, int ntrials, int p)
{
    for (int i = 0; i < ntrials; ++i) {
        MPI_Recv(buf, n, MPI_CHAR, p, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Send(buf, n, MPI_CHAR, p, 0, MPI_COMM_WORLD);
    }
}


int main(int argc, char** argv)
{
    #define MAX_SZ 16384

    int rank, ntrials, pdest;
    static char buf[MAX_SZ];

    MPI_Init(&argc, &argv);

    memset(buf, 0, sizeof(buf));
    pdest   = (argc < 2 ? 1      : atoi(argv[1]));
    ntrials = (argc < 3 ? 100000 : atoi(argv[2]));

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    for (int sz = 1; sz <= MAX_SZ; sz += 1000) {
        if (rank == 0) {
            double t = MPI_Wtime();
            ping(buf, sz, ntrials, pdest);
            t = MPI_Wtime()-t;
            printf("%d %g\n", sz, t/(2*ntrials));
        } else if (rank == pdest) {
            pong(buf, sz, ntrials, 0);
        }
    }

    MPI_Finalize();
    return 0;
}
