#!/bin/bash
for (( i=0; i<=10000; i+=100 ))
do
tstep=$(printf "%08d" $i)
./extract -k vel.001-001.meta vel-${tstep}.001-001
done
