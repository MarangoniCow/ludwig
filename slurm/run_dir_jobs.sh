#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)

SCRIPTNAME='viking_test'
NTASKS=2
MEM=2

sbatch --ntasks=$NTASKS --mem=${MEM}gb --job-name=$SCRIPTNAME --output=${BATCHDIR}/logs/%x_J%j --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/run_multicore.job




#for i in ./3DC_*.inp; do
#	SCRIPTNAME=$( echo $i | awk '{ print substr( $0, 3 ) }')
#	echo $SCRIPTNAME
#	sbatch --job-name=$SCRIPTNAME --export=SCRIPTNAME=$SCRIPTNAME ../../scripts/ludwig/swimmer_confinement.job
#done
 




