#!/bin/bash

#SBATCH -A SNIC2020-9-36
#SBATCH -t 20:00:00
#SBATCH -n 1

# It is always best to do a ml purge before loading modules in a submit file
ml purge > /dev/null 2>&1

# Load the module for GROMACS and its prerequisites.
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

mkdir rdf

for T in $(seq 180 10 300)
do

for t in $(seq 100 100 10000)
do

# dump a single frame (without dummy atoms)
gmx trjconv -f md_${T}.xtc -s md_${T}.tpr -dump ${t} -o rdf/md_${T}_${t}.pdb -n md_noMW_${T}.ndx -pbc atom -center << EOF
0
EOF

# remove hydrogens
grep -v '        H' rdf/md_${T}_${t}.pdb > rdf/md_${T}_${t}_noH.pdb 

# calculate rdf
gmx rdf -f rdf/md_${T}_${t}_noH.pdb  -s rdf/md_${T}_${t}_noH.pdb -o rdf/rdf_${T}_${t}.xvg -dt ${t} -sel "name OW and not within 0.24 of (not resname SOL)" -ref "name OW and not within 0.24 of (not resname SOL)"


# clean up
rm rdf/md_${T}_${t}.pdb
rm rdf/md_${T}_${t}_noH.pdb

done
done

