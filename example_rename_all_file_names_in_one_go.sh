#http://askubuntu.com/questions/406313/change-multiple-filenames-by-replacing-a-character
#changes "1.75" to "1_75" in all files in the current folder
#for i in *1.75*; do mv "$i" "${i//1.75/1_75}"; done

# remove CxAODFramework_ from all the files in this folder
#for i in CxAODFramework_*; do mv "$i" "${i//CxAODFramework_/}"; done

# to replace adi and bla in all .txt
#for i in *.txt ; do mv "$i" "${i//adi/bla}"; done

# to replace Dyn. with Dyn_ in all .pdf
#for i in *.pdf ; do mv "$i" "${i//Dyn./Dyn_}"; done

# replace all dphill to dphi in all .png
#for i in *.png ; do mv "$i" "${i//dphill/dphi}"; done

# on git raname files from mc16h to mc16hp
#for i in *mc16h*.txt ; do git mv "$i" "${i//mc16h/mc16hp}"; done

# convert all pdf in png
# for i in plot_*pdf ; do convert "$i" "${i//pdf/png}"; done
