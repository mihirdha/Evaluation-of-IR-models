%This script performs grid search by changing the schema file in each run and stores evaluation measure values after trec_eval
#echo 5/2|bc -l
k1=1
b=1
n=1
incrk1=0.5
k2=$k1/5|bc -l
#!/bin/bash

declare -i k1=5

# use the number multiplied by 10

while [ $k1 -le 25 ]

do
	k1=`expr "$k1 + 5" | bc`;
	declare -i b=4
	while [ $b -le 8 ]
	do                  
		b=`expr "$b + 1" | bc`;
		str="683s/.*/<float name=\"k1\">`echo "$k1" | sed "s/[0-9]$/\.&/"`<\/float> <float name=\"b\">0`echo "$b" | sed "s/[0-9]$/\.&/"`<\/float>/"
	 	sed  -i "$str" /home/mihirdha/solr/solr-5.3.0/projectB/solr/projectB/conf/schema.xml
		./deindex.sh
		./stop.sh
		./start.sh
		./index.sh
		rm -rf res/1.txt
		python json_to_trec.py
		./trec_eval -q -c -M 1000 -m ndcg qrel.txt res/1.txt>res/ndcg-`echo "$k1" | sed "s/[0-9]$/\.&/"`-`echo "$b" | sed "s/[0-9]$/\.&/"`.txt
		./trec_eval -q -c -M 1000 -m map qrel.txt res/1.txt>res/map-`echo "$k1" | sed "s/[0-9]$/\.&/"`-`echo "$b" | sed "s/[0-9]$/\.&/"`.txt
		./trec_eval -q -c -M 1000 -m set_F.0.5 qrel.txt res/1.txt>res/set_F.0.5-`echo "$k1" | sed "s/[0-9]$/\.&/"`-`echo "$b" | sed "s/[0-9]$/\.&/"`.txt
		
				
		echo "k1=$k1" | sed "s/[0-9]$/\.&/" # sed inserts a decimal point before the last digit
		echo "b=$b" | sed "s/[0-9]$/\.&/"
		echo $str
	done
done
#echo $k2
#echo $k1+1/2 |bc -l|bc-l
#echo $k1
#while [[ $k1 -le 3 ]]
#do
#	echo "Welcome $n times."
	
#	k1=`echo $k1 + $incr | bc`
	#k1=$(( k1+0.5 ))	 # increments $n

#done
#str='683s/.*/<float name="k1">'$k1'<\/float> <float name="b">'$b'<\/float>/'
#echo $str
#sed  "$str" /home/mihirdha/solr/solr-5.3.0/projectB/solr/projectB/conf/schema.xml
#sed  '683s/.*/<float name="k1">1.4<\/float> <float name="b">0.8<\/float>/' /home/mihirdha/solr/solr-5.3.0/projectB/solr/projectB/conf/schema.xml
