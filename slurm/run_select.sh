#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)


NTASKS=20
MEM=12


inputArr=("./3DC_Pl_AH_01" "./3DC_Pl_AH_05" "./3DC_Pl_AH_07" "./3DC_Pu_AH_03")


for i in ${inputArr[@]}; do
	temp=$( echo $i | awk '{ print substr( $0, 3 ) }')
	SCRIPTNAME=$(echo "$temp" | cut -f 1 -d '.')
	echo $SCRIPTNAME
	sbatch --ntasks=$NTASKS --ntasks-per-node=$NTASKS --mem=${MEM}gb --job-name=$SCRIPTNAME --time=24:00:00 --output=${BATCHDIR}/logs/%x_J%j --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/run_multicore.job
done
