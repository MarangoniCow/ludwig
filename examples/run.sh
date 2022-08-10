#!/bin/bash


# Check for input
if [[ $# -lt 1 ]]
then
	echo "Please enter example, e.g. \"3DChannel\""
	read file_name
else
	filename=$1
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
mpirun ../../Ludwig.exe ../../$filename.inp
cd ~


