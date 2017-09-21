CC=mpicc
CFLAGS=-std=gnu99 -Wall
MPIRUN=mpirun

.PHONY: run-local run-cluster clean

run-local: laptop.tikz

laptop.txt: ping.x
	$(MPIRUN) -n 2 ./ping.x > laptop.txt

run-cluster: ping.x
	qsub job-ping.pbs

laptop.tikz: laptop.txt
	octave plotter.m

ping.x: ping.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f ping.x laptop.txt laptop.tikz

