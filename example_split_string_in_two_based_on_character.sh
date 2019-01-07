#!/bin/sh
#if there is no parameter, it stops and it gives the instructions
if [ $# -ne 0 ]; then
cat <<EOF
Usage: $0 
EOF
exit 1
fi

# temp                                                                                                                                                                                    
# https://stackoverflow.com/questions/4168371/how-can-i-remove-all-text-after-a-character-in-bash
# In Bash (and ksh, zsh, dash, etc.), you can use parameter expansion
# with # which will remove characters from the beginning of the string.
# with % which will remove characters from the end of the string
# If you use a single one of those characters, the smallest matching string will be removed.
# If you double the character, the longest will be removed.

z="group.phys-higgs.data18_13TeV.00356205.CAOD_HIGG5D2.f956_m2004_p3640.32-07-3/"
a="${z#*.}"  # Removes until the first dot and also the dot. Keeps what is after the first dot. # a=phys-higgs.data18_13TeV.00356205.CAOD_HIGG5D2.f956_m2004_p3640.32-07-3/
b="${z##*.}" # Removes until the last  dot and also the dot. Keeps what is after the last  dot. # b=32-07-3/
c="${z%.*}"  # Removes from the last  dot until the end. Keeps what is before the last dot.     # c=group.phys-higgs.data18_13TeV.00356205.CAOD_HIGG5D2.f956_m2004_p3640
d="${z%%.*}" # Removes from the first dot until the end. Keeps what is before the first dot.    # d=group
echo "a=${a}"
echo "b=${b}"
echo "c=${c}"
echo "d=${d}"

exit
