#!/bin/bash
set -e

# SCRIPT USAGE
# Automates the extraction of data from files. 

cwd=$(pwd)

# Check for input
if [[ $# -lt 1 ]]
then
	echo "Enter example to clean, without extensions, e.g. \"3DChannel\""
	read filename
else
	filename=$1
fi

# Check for validity
if [ -d "./$filename/data" ]
then
	echo "Removing $filename" raw data
else
	echo "Error: $filename is invalid"
	exit 0
fi

# Navigate to example
cd ./$filename/data

for i in ./*.001-001; do
	rm ${i}
done

cd ~


