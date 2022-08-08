#!/bin/bash
for (( i=250; i<=2500; i+=250 ))
do
tstep=$(printf "%08d" $i)
#./extract -k vel.001-001.meta vel-${tstep}.001-001
./extract_colloids config.cds${tstep} 1 col-cdsvel-${tstep}.001-001.csv
done
