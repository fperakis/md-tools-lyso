#!/bin/bash
cd ..
mkdir data
cd data
for R in $(seq 0 1 9)
do 
  mkdir R${R}
  cd R${R}
  sh ../../scripts/pipeline.sh
  cd ..
done
