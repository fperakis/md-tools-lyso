#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  for T in $(seq 180 10 300)
  do
    gmx select -s md_${T}.gro -f md_${T}.xtc -on md_noMW_${T}.ndx -xvg none -select "all and not name MW"
    gmx editconf -f md_${T}.tpr -n md_noMW_${T}.ndx -o md_noMW_${T}.gro -pbc no
    gmx trjconv -s md_${T}.tpr -f md_${T}.xtc -o md_noMW_${T}.xtc -n md_noMW_${T}.ndx -pbc mol -ur compact -center
    gmx energy -f md_${T}.edr -o md_volume_${T}.xvg < ../../src/c20.txt
    gmx energy -f md_${T}.edr -o md_potential_${T}.xvg < ../../src/c10.txt
    # run SAXS calculation
    cp ../../batch/saxsT_CPU.sh saxs_${T}.sh
    sed -i "s/300/$T/g" saxs_${T}.sh
    # submit job
    sbatch saxs_${T}.sh
  done
  cd ..
done
squeue -lu fperakis
