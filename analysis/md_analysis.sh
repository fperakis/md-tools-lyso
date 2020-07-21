#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
cd R${R}

# extract volume
gmx energy -f md.edr -o md_volume.xvg << EOF
20
EOF

# extract potential
gmx energy -f md.edr -o md_potential.xvg << EOF
10
EOF

cd ..
done
