# MD-TOOLS-LYSO

This is a collection of tools for running GROMACS simulations on HPC2N (Kebnekaise)

-----
## PDB file:

Here is used a protein crystal.pdb from 1kaki.pdb which is maded using pymol:

```bash 
$ symexp sym, 1aki, 1aki, 31
```

this cut-off yields 41 proteins, where 32 were selected 

------------
## PIPELINE

### LOAD GROMACS 2019

```bash 
$ ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4

$ ml GROMACS/2019.4-PLUMED-2.5.4

$ cd scripts
```

### EQUILIBRATION (uses pipeline.sh)
```bash 
$ bash loop_em.sh
```

### NVT
```bash 
$ bash loop_nvt.sh

$ bash ../analysis/nvt_analysis.sh
```

### NPT
```bash 
$ bash loop_npt.sh

$ bash ../analysis/npt_analysis.sh
```
### MD
```bash 
$ bash loop_md.sh

$ bash ../analysis/md_analysis.sh
```

### MD multiple Temperatures
```bash 
$ bash loop_mdT.sh

$ bash ../analysis/mdT_analysis.sh
```
