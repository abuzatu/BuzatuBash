# for file in echo `ls -1 *.html`;do cat $file | sed -e 's/ro_index/ro_overview/' > temp; mv temp $file; done
for file in echo `ls -1 run*.py`;do cat $file | sed -e 's/3600/1200/' > temp; mv temp $file; done
for file in echo `ls -1 run*.py`;do echo $file; cat $file | sed -e 's/3600/1200/' > adi; echo "file_2=${file}_2"; mv ${file_2} ${file}_3; done
