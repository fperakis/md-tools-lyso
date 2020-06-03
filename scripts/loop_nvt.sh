#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx grompp -f ../../mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
  sbatch ../../batch/nvt_GPU.sh
  cd ..
done
squeue -lu fperakis
