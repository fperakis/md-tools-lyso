#!/bin/bash
cd ../data/

# loop over realisations
for R in $(seq 1 1 1)
do 
cd R${R}
mkdir saxs

# loop over temperatures
for T in $(seq 180 10 300)
do

# loop over time
for t in $(seq 1000 1000 10000)
do

# update submission script
cp ../../batch/saxs.sh saxs/saxs_${T}_${t}.sh
sed -i "s/300/$T/g" saxs/saxs_${T}_${t}.sh
sed -i "s/10000/$t/g" saxs/saxs_${T}_${t}.sh

# submit jobs
sbatch saxs_${T}_${t}.sh

done # time loop
done # temperature loop
cd ..
done # realisation loop

# check queue
squeue -lu fperakis  


