#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx select -s md.gro -f md.xtc -on md_noMW.ndx -xvg none -select "all and not name MW"
  gmx editconf -f md.tpr -n md_noMW.ndx -o md_noMW.gro -pbc no
  gmx trjconv -s md.tpr -f md.xtc -o md_noMW.xtc -n md_noMW.ndx -pbc mol -ur compact -center
  gmx energy -f md.edr -o md_volume.xvg < ../../src/c20.txt
  gmx energy -f md.edr -o md_potential.xvg < ../../src/c10.txt
  sh ../../batch/saxs_CPU.sh
  cd ..
done
