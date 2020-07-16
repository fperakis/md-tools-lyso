#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
cd R${R}

gmx energy -f npt.edr -o npt_volume.xvg << EOF
20
EOF

gmx energy -f npt.edr -o npt_potential.xvg << EOF
10
EOF

  cd ..
done
