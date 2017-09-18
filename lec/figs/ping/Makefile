CC=mpicc
CFLAGS=-std=gnu99 -Wall
MPIRUN=mpirun

.PHONY: run clean

run: ping.x
	$(MPIRUN) -n 2 ./ping.x > laptop.txt
	octave plotter.m

ping.x: ping.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f ping.x laptop.txt laptop.tikz

