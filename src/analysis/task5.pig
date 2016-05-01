--1. Sort & rank
REGISTER  /Users/chenhuichun/Desktop/0411project/workspace/apache-datafu-incubating-sources-1.3.0/datafu-pig/build/libs/datafu-pig-incubating-1.3.0.jar;
REGISTER ./pigtmp/tutorial.jar;
--define Enumerate datafu.pig.bags.Enumerate('1');

raw = LOAD '/user/chenhuichun/Input/Fulltable_score_h_6.csv' USING PigStorage(',') AS  --/user/chenhuichun/Input/
(MTA_zipcode:int, --MTA info
entry_name:chararray, 
entry_lati:double, 
entry_longi:double,
store_zipcode:int, --store info
store_neighbor:chararray,
store_name:chararray,
store_lati:double, 
store_longi:double,
category:chararray,
rating:double,
distance:double,
score:double); 


group_zipcode = GROUP raw BY (entry_name, category);


order_score = FOREACH group_entry_category 
{
	projected = FOREACH raw GENERATE store_name, store_zipcode, store_neighbor, rating, distance, score;
	tmp = DISTINCT projected;
	ordered = ORDER tmp BY score DESC ;
	--GENERATE group, ordered;
	GENERATE group AS entry_category , ordered AS row ;
}

temp = FOREACH order_score GENERATE FLATTEN(entry_category),FLATTEN(row);
--table = FOREACH order_score GENERATE flatten($0), COUNT($1) as count;
clean = FOREACH temp GENERATE $0, $1, $2, $3, $4, $5, $6, ROUND_TO($7,4);

STORE clean INTO 'task5' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run task5.pig;
grunt> fs -getmerge task5/ Fulltable_sort_h_6_full.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/