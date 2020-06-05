#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx select -s npt.gro -f npt.xtc -on npt_noMW.ndx -xvg none -select "all and not name MW"
  gmx editconf -f npt.tpr -n npt_noMW.ndx -o npt_noMW.gro -pbc no
  gmx trjconv -s npt.tpr -f npt.xtc -o npt_noMW.xtc -n npt_noMW.ndx -pbc mol -ur compact -center
  gmx energy -f npt.edr -o npt_volume.xvg < ../../src/c20.txt
  gmx energy -f npt.edr -o npt_potential.xvg < ../../src/c10.txt
  cd ..
done
