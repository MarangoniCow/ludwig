#!/bin/bash
set -e

# Check for input
if [[ $# -lt 1 ]]
then
	echo "Please enter example string, e.g. \"3DChannel\""
	read file_name
else
	filename=$1
fi

# Check for validity
if [[ -f "./$filename/data" ]]
then
	echo "Extracting $filename"
else
	echo "Error: $filename is invalid"]
	exit 0
fi

# Run example
mkdir -p ./$filename/data
cd ./$filename/data

# Fetch number of files
n_v=$(find ./ -name "vel*" | wc -l)
n_q=$(find ./ -name "q*" | wc -l)
n_c=$(find ./ -name "config*" | wc -l)

# If non-zero number of relevant files exist, fetch them
if [ $n_v -gt 0 ]
then
	for i in ./vel-*.001-001; do
		../../extract -k vel.001-001.meta $i
		echo $i
	done
fi
if [ $n_q -gt 0 ]
then
	for i in ./q-*.001-001; do
		../../extract -k -s -d  q.001-001.meta $i
	done
fi
if [ $n_c -gt 0 ]
then
	for i in ./config.*.001-001; do
		# Extra steps to extract number
		temp=${i#*cds};
		num=$(echo "$temp" | cut -f 1 -d '.')
		../../extract_colloids config.cds${num} 1 col-cdsvel-${num}.csv
	done
fi

cd ~


