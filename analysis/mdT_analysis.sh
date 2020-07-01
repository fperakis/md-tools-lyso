#!/bin/bash
cd ../data/

for R in $(seq 0 1 9)
do 

cd R${R}

for T in $(seq 180 10 300)
do

# make index file with non-dummy atoms
gmx select -s md_${T}.gro -f md_${T}.xtc -on md_noMW_${T}.ndx -xvg none -select "all and not name MW"

# extract volume
gmx energy -f nvt.edr -o nvt_volume.xvg << EOF
20
EOF

# extract potential 
gmx energy -f nvt.edr -o nvt_potential.xvg << EOF
10
EOF

done
cd ..

done

squeue -lu fperakis
