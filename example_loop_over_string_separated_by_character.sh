#!/bin/sh
#if there is no parameter, it stops and it gives the instructions
if [ $# -ne 1 ]; then
cat <<EOF
EOF
Usage: ./doThinTrees.sh WH115+ZH115
EOF
exit 1
fi

PROCESSes=$1


for PROCESS in `echo "${PROCESSes}" | awk -v RS=+ '{print}'`
do
    echo $PROCESS
done
