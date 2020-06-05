#!/bin/bash

#SBATCH -A SNIC2020-9-36
#SBATCH -t 30:00:00
#SBATCH -n 1

# It is always best to do a ml purge before loading modules in a submit file
ml purge > /dev/null 2>&1

# Load the module for GROMACS and its prerequisites.
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

gmx saxs -f md.xtc -s md.gro -n md_noMW.ndx -sq saxs.xvg -energy 8.041
