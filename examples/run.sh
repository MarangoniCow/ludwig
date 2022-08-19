#!/bin/bash

# USAGE
# Automates running ludwig from an input file name.
# ------------------------------------------------
# INPUTS
# $1 	- filename
# $2 	- number of tasks

# Check for input
if [[ $# -lt 2 ]]
then
	echo "Enter example name without extensions, e.g. \"3DChannel\""
	read filename
	echo "Enter number of tasks"
	read ntasks
else
	filename=$1
	ntasks=$2
fi

# Check for validity
if [[ -f "./$filename.inp" ]]
then
	echo "Running $filename"
else
	echo "Error: $filename not a valid input file."
	exit 0
fi

# Run example
mkdir -p ./$filename/data
cd ./$filename/data
mpirun -np $ntasks ../../Ludwig.exe ../../$filename.inp
cd ~


