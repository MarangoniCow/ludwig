#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)


NTASKS=20
MEM=20




SCRIPTNAME=force_failure
sbatch --ntasks=$NTASKS  --ntasks-per-node=5 --mem=${MEM}gb --job-name=$SCRIPTNAME --output=${BATCHDIR}/logs/%x_J%j --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/output_failure.job
 




