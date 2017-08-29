# Note: You will need to use a compiler with OpenMP in order to
# get the omp_get_wtime() routines to work.

CC = gcc-7
CFLAGS = -std=c99 -O2 -fopenmp
LIBS = -lrt
PYTHON = python

.PHONY: run clean clean-all

run: timings-line.pdf timings-heat.pdf

membench: membench.c
	$(CC) $(CFLAGS) -o membench membench.c

timings-line.pdf timings-heat.pdf: timings.csv
	$(PYTHON) ./mbplot.py timings

timings.csv: membench
	./membench timings.csv

clean:
	rm -f membench
	rm -f timings-line.pdf timings-heat.pdf

clean-all: clean
	rm -f timings.csv
