#!/bin/bash
cd ../data/

# loop over realisations
for R in $(seq 1 1 1)
do 
cd R${R}
mkdir rdf

cp ../../batch/rdf.sh rdf/rdf_${R}.sh

# submit jobs
sbatch rdf/rdf_${R}.sh

cd ..
done # realisation loop

# check queue
squeue -lu fperakis  


