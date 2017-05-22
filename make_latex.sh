#!/bin/bash

if [ $# -ne 1 ]; then
cat <<EOF
Usage: $0 Folder
Usage: $0 /afs/phas.gla.ac.uk/user/a/abuzatu/public_ppe/RivetHbbBJets
EOF
exit 1
fi 

FOLDER=$1
OUTPUT_FILE="plots.tex"

# go to the folder that has the files 
pushd ${FOLDER}

rm -f ${OUTPUT_FILE}
touch ${OUTPUT_FILE}
# create the code for latex/beamer
(


echo "\\documentclass{beamer}" 
echo "\\usepackage{epstopdf}"
echo "\\usepackage{tabularx}"
echo "\\usepackage{adjustbox}"
echo "\\usepackage{pdflscape}"
echo "\\usepackage[]{hyperref}"
echo "\\usepackage{adjustbox}"
echo "\\usepackage{pdflscape}"
echo "\\usepackage{multirow}"
echo "\\usepackage{multicol}"
echo "\\usetheme{Madrid}"
echo "\\title{Plots made automatically}"
echo "\\begin{document}"
echo "\\frame{\titlepage}"
echo ""
echo ""
# Before looping over plots


# loop over plots
for FILE in `ls -1 overlay_150_250_*tag_ttbar_SysFT_EFF_Eigen_C_0_AntiKt4EMTopoJets*png`
do
    #echo "FILE=${FILE}"
    STEM=${FILE%.*} # remove the extension like .png
    #echo "STEM=${STEM}"
    echo ""
    echo "\\begin{frame} { \tiny {\texttt{\detokenize{${STEM}}}} }"
    echo "\centering"
    #echo "\\includegraphics[width=0.78\\textwidth]{${FILE}}"
    echo "\\includegraphics[height=0.85\\textheight]{${FILE}}"
    echo "\\end{frame}"

done
echo ""
echo "\\end{document}"

# after looping over plots
) > "${OUTPUT_FILE}"

# complile the slide
pdflatex ${OUTPUT_FILE}
# open the pdf of the slides
OUTPUT_PDF=${OUTPUT_FILE%.*}.pdf
open ${OUTPUT_PDF}

# return to folde r when we run from
popd

exit
