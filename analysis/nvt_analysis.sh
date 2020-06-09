#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
cd R${R}
gmx energy -f nvt.edr -o nvt_volume.xvg << EOF
20
EOF

gmx energy -f nvt.edr -o nvt_potential.xvg << EOF
10
EOF

cd ..
done
