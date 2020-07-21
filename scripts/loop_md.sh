#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx grompp -f ../../mdp/md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
  sbatch ../../batch/md_GPU.sh
  cd ..
done
squeue -lu fperakis
