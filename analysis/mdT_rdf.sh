#!/bin/bash
cd ../data/

# loop over realisations
for R in $(seq 0 1 0)
do 
cd R${R}
mkdir rdf

cp ../../batch/rdf.sh saxs/rdf_${R}.sh

# submit jobs
sbatch rdf/saxs_${T}_${t}.sh

cd ..
done # realisation loop

# check queue
squeue -lu fperakis  


