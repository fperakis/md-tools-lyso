#!/bin/bash
cd ../data/
for R in $(seq 0 1 9)
do 
cd R${R}
gmx select -s md.gro -f md.xtc -on md_noMW.ndx -xvg none -select "all and not name MW"
gmx editconf -f md.tpr -n md_noMW.ndx -o md_noMW.gro -pbc no
gmx trjconv -s md.tpr -f md.xtc -o md_noMW.xtc -n md_noMW.ndx -pbc mol -ur compact -center
gmx energy -f nvt.edr -o nvt_volume.xvg << EOF
20
EOF

gmx energy -f nvt.edr -o nvt_potential.xvg << EOF
10
EOF

sh ../../batch/saxs_CPU.sh
cd ..

done
