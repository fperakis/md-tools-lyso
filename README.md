# MD-TOOLS

This is a collection of tools for running GROMACS simulations on HPC2N (Kebnekaise)

## PROJECT NUMBERS:

* SNIC 2020/5-289 - medium alocation (90'000 CPU h/month)

* SNIC 2020/9-36  - small alocation  (5'000  CPU h/month)

-----
## PDB file:

Here is used a protein crystal.pdb from 1kaki.pdb which is maded using pymol:

$ symexp sym, 1aki, 1aki, 31 (41 proteins - selected 32)

------------
## PIPELINE

### LOAD GROMACS 2019
$ ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4

$ ml GROMACS/2019.4-PLUMED-2.5.4

$ cd scripts

### EQUILIBRATION (uses pipeline.sh)
$ sh loop_em.sh

### NVT
$ sh loop_nvt.sh
$ sh nvt_analysis.sh

### NPT
$ sh loop_npt.sh
$ sh npt_analysis.sh

### MD 
$ sh loop_md.sh
$ sh md_analysis.sh

### MD multiple Temperatures
$ sh loop_mdT.sh

$ sh mdT_analysis.sh
