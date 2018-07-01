#!/bin/bash

if [ $# -ne 1 ]; then
cat <<EOF
Usage: $0 Folder
Usage: $0 afs/phas.gla.ac.uk/user/a/abuzatu/public_ppe/RivetHbbBJets
EOF
exit 1
fi 

FOLDER=$1
INDEX_FILE="index.html"

# go to the folder that has the files 
pushd ${FOLDER}

rm -f ${INDEX_FILE}

for FILE in `ls -1 *.pdf`
do
    STEM=${FILE%.*}
    # if .png file does not exist, convert .pdf in .png
    if [ ! -f "${STEM}.png" ]; then
	echo "File ${STEM}.png not found, so converting ${STEM}.pdf to ${STEM}.png"
	convert ${FILE} ${STEM}.png
    fi
    echo "<br> ${STEM} <br>" >> ${INDEX_FILE}
    echo "<br> <a href=\"./${STEM}.pdf\"> <img src=\"./${STEM}.png\" alt=\"Mountain View\"> </a> <br>" >> ${INDEX_FILE}
done

# return to folde r when we run from
popd

exit
