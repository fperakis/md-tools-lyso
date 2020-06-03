#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  for T in $(seq 180 10 300)
  do
    # update mdp file
    cp ../../mdp/md.mdp md_${T}.mdp
    sed -i "s/300/$T/g" md_${T}.mdp
    # run gromp
  	gmx grompp -f md_${T}.mdp -c md.gro -t md.cpt -p topol.top -o md_${T}.tpr
    # update submission script
    cp ../../batch/submit_mdT.sh md_${T}.sh
    sed -i "s/300/$T/g" md_${T}.sh
    # submit job
  	sbatch md_${T}.sh
  done
  cd ..
done
squeue -lu fperakis
