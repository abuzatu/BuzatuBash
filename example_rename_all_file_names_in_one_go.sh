#http://askubuntu.com/questions/406313/change-multiple-filenames-by-replacing-a-character
#changes "1.75" to "1_75" in all files in the current folder
#for i in *1.75*; do mv "$i" "${i//1.75/1_75}"; done

# remove CxAODFramework_ from all the files in this folder
#for i in CxAODFramework_*; do mv "$i" "${i//CxAODFramework_/}"; done

# to replace adi and bla in all .txt
#for i in *.txt ; do mv "$i" "${i//adi/bla}"; done

# to replace Dyn. with Dyn_ in all .pdf
#for i in *.pdf ; do mv "$i" "${i//Dyn./Dyn_}"; done
