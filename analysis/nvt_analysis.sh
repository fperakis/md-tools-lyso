#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx energy -f nvt.edr -o nvt_volume.xvg < ../../src/c20.txt
  gmx energy -f nvt.edr -o nvt_potential.xvg < ../../src/c10.txt
  cd ..
done
