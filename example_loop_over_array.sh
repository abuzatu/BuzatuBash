#!/bin/bash
#if there is no parameter, it stops and it gives the instructions
if [ $# -ne 0 ]; then
cat <<EOF
EOF
Usage: ./run.sh
EOF
exit 1
fi

FOLDERPATH="http://www.ppe.gla.ac.uk/~fergush/PtReco"
FILESTEM="tree_llbb_5_1_75_"

# Array pretending to be a Pythonic dictionary
ARRAY_FOLDER=( "GaussMean_Errors:Gauss_Results"
"GaussMean_NoErrors:Gauss_Results"
"HistoMean_Errors:Histo_Results"
"HistoMean_NoErrors:Histo_Results" )

# Array pretending to be a Pythonic dictionary
ARRAY_TYPE=( "all:all_nosld_sigma_1_75"
"nosld:all_nosld_sigma_1_75"
"el:el_sigma_1_75"
"mu:mu_sigma_1_75" )

for elementfolder in "${ARRAY_FOLDER[@]}" ;
do
echo " "
KEY="${elementfolder%%:*}"
VALUE="${elementfolder##*:}"
#printf "%s in %s.\n" "$KEY" "$VALUE"
FOLDER=${KEY}
FOLDER1=${VALUE}
mkdir -p ${FOLDER}
cd ${FOLDER}
for elementtype in "${ARRAY_TYPE[@]}" ;
do
KEY="${elementtype%%:*}"
VALUE="${elementtype##*:}"
#printf "%s in %s.\n" "$KEY" "$VALUE"
TYPE=${KEY}
FOLDER2=${VALUE}
#
File="${FOLDERPATH}/${FOLDER1}/${FOLDER}/${FOLDER2}/${FILESTEM}${TYPE}.pdf"
#echo ${File}
command="wget ${File}"
`echo ${command}`
done
cd ..
done

exit
