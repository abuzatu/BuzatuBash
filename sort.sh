#!/bin/bash

for f in `ls -1 *.txt`
do
    echo ${f}
    wc -l ${f}
    sort ${f} > ${f}_sorted
    mv ${f}_sorted $f
done
