ls -1 | grep -v NN_2 | grep -v NN_3 | xargs  -I{} cp "{}" ./my_folder/.
