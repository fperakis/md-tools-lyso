#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
cd R${R}
gmx energy -f em.edr -o em_volume.xvg << EOF
20
EOF

gmx energy -f em.edr -o em_potential.xvg << EOF
10
EOF

cd ..
done
