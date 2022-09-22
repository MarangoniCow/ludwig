#!/bin/bash


BATCHDIR='/users/mjs572/scratch/ludwig/slurm' 
cwd=$(pwd)


NTASKS=20
MEM=20



INT_TIME=300

for i in ./3DC_Pa_AH_*.inp; do
	temp=$( echo $i | awk '{ print substr( $0, 3 ) }')
	SCRIPTNAME=$(echo "$temp" | cut -f 1 -d '.')
	echo $SCRIPTNAME
	MIN=$(( $INT_TIME%60 ))
	MIN=$( printf '%02d' $MIN )
	HOUR=$(( $INT_TIME/60 ))
	HOUR=$( printf '%02d' $HOUR )
	INT_TIME=$(( $INT_TIME*5/4 ))
	######## TEMP EDIT ##############
	# Just set everything to 48hr...
	sbatch --ntasks=$NTASKS --ntasks-per-node=$NTASKS --mem=${MEM}gb --job-name=$SCRIPTNAME --time=48:00:00 --output=${BATCHDIR}/logs/%x_J%j --export=SCRIPTNAME=$SCRIPTNAME ${BATCHDIR}/run_multicore.job
done
