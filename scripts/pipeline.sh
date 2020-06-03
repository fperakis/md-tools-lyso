#!/bin/bash

## LOAD GROMACS 2019
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

# remove waters from pdb
grep -v HOH ../../src/crystal.pdb > crystal_clean.pdb

# add hydrogens, make topology
gmx pdb2gmx -f crystal_clean.pdb -o crystal_processed.gro -water tip4p <<EOF
15
EOF

# modify the topol.top #include "oplsaa.ff/tip4p.itp" to #include "oplsaa.ff/tip4pew.itp"
sed -i 's/tip4p.itp/tip4pew.itp/g' topol.top

# make new box (with extra space for the solvation)
gmx editconf -f crystal_processed.gro -o crystal_newbox.gro -c -bt cubic -d 1 

# solvate
gmx solvate -cp crystal_newbox.gro -cs tip4p -o crystal_solv.gro -p topol.top -shell 0.23 

# add ions to neutralise
gmx grompp -f ../../mdp/ions.mdp -c crystal_solv.gro -p topol.top -o ions.tpr
gmx genion -s ions.tpr -o crystal_solv_ions.gro -p topol.top -pname NA -nname CL -neutral -rmin 0.2 <<EOF
13
EOF

# make new box (back to compact one)
gmx editconf -f crystal_solv_ions.gro -o crystal_sml.gro -c -bt cubic -d 0 

# Energy minimization (needs minim.mdp)
gmx grompp -f ../../mdp/minim.mdp -c crystal_sml.gro -p topol.top -o em.tpr

# run em submission script
sbatch ../../batch/em_CPU.sh

# check queue
squeue -l -u fperakis 
