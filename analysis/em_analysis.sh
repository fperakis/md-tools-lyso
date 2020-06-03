#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
  cd R${R}
  gmx energy -f em.edr -o em_volume.xvg < ../../src/c20.txt
  gmx energy -f em.edr -o em_potential.xvg < ../../src/c10.txt
  cd ..
done
