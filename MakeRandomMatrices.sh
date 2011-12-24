#!/bin/bash
set -e # stop execution if there is an error
# make data folder if it doesn't exist
if [ ! -d data ]
    then
    mkdir data
fi

javac -sourcepath java java/SparseMatrixGenerator.java
prob="0.05"
degree="100"

for i in {1..20}
do
    echo "generating matrix: ${i}"
    java -classpath java SparseMatrixGenerator $[${i}*$degree] ${prob} > sparse${i}.csv
    mv sparse${i}.csv data
done
echo "done"