#!/bin/bash


# Check for input
if [[ $# -lt 1 ]]
then
	echo "Please enter example string, e.g. \"3DChannel\""
	read file_name
else
	filename=$1
fi

# Check for validity
if [[ -f "./$filename/$filename.inp" ]]
then
	echo "Building $filename"
else
	echo "Invalid example name"
fi

# Run example
mkdir -p ./$filename/data
cd ./$filename/data
mpirun ../../Ludwig.exe ../$filename.inp
cd ~


