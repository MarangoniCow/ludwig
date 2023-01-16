#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)


NTASKS=1
MEM=4


inputArr=("./ColloidTest01")


for i in ${inputArr[@]}; do
	temp=$( echo $i | awk '{ print substr( $0, 3 ) }')
	SCRIPTNAME=$(echo "$temp" | cut -f 1 -d '.')
	echo $SCRIPTNAME
	sbatch --ntasks=$NTASKS --ntasks-per-node=$NTASKS --mem=${MEM}gb --job-name=$SCRIPTNAME --time=00:30:00 --output=${BATCHDIR}/logs/%x_J%j --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/run_multicore_w_matlab.job
done
