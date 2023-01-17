#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)


NTASKS=20
MEM=20
HRS=12


for i in ./3DP_Pu_Q2D_H1_*.inp; do
	temp=$( echo $i | awk '{ print substr( $0, 3 ) }')
	SCRIPTNAME=$(echo "$temp" | cut -f 1 -d '.')
	echo $SCRIPTNAME
	sbatch --ntasks=$NTASKS --ntasks-per-node=$NTASKS --mem=${MEM}gb --job-name=$SCRIPTNAME --time=$HRS:00:00 --output=${BATCHDIR}/logs/%x_J%j --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/run_multicore_w_matlab.job
done
