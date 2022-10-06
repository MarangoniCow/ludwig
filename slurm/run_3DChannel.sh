#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)


NTASKS=4
MEM=4
TIME='00:10:00'
SCRIPTNAME='3DChannel'



sbatch --ntasks=$NTASKS  --ntasks-per-node=$NTASKS --mem=${MEM}gb --job-name=$SCRIPTNAME --output=${BATCHDIR}/logs/%x_J%j --time=$TIME --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/run_multicore.job
 




