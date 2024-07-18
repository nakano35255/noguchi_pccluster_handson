#!/bin/bash

#SBATCH -p defq
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1

srun -n 1 -N 1 ./out.exe
