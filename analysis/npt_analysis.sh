#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
cd R${R}
gmx select -s npt.gro -f npt.xtc -on npt_noMW.ndx -xvg none -select "all and not name MW"
gmx editconf -f npt.tpr -n npt_noMW.ndx -o npt_noMW.gro -pbc no
gmx trjconv -s npt.tpr -f npt.xtc -o npt_noMW.xtc -n npt_noMW.ndx -pbc mol -ur compact -center

gmx energy -f nvt.edr -o nvt_volume.xvg << EOF
20
EOF

gmx energy -f nvt.edr -o nvt_potential.xvg << EOF
10
EOF

  cd ..
done
