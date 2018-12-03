find ../out/ -name *.txt -exec  sh -c 'cat "{}" >> ../out/result.dat' \;
tr '\r' '\n' < ../out/result.dat > ../out/result2.dat
#./fasttext supervised -input ../out/result2.dat -output news -dim 100 -lr 0.1 -wordNgrams 2 -minCount 1 -bucket 10000000 -epoch 300 -thread 4;
