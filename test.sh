#!/bin/bash

#SBATCH -p defq
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -c 1

srun --exclusive --mem-per-cpu=1840 -n 4 -N 1 ./a.out &

wait