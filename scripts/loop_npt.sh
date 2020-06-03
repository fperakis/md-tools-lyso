#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx editconf -f nvt.gro -o nvt_tric.gro -c -bt triclinic -d 0
  gmx grompp -f ../../mdp/npt.mdp -c nvt_tric.gro -r nvt_tric.gro -p topol.top -o npt.tpr
  sbatch ../../batch/npt_GPU.sh
  cd ..
done
squeue -lu fperakis
