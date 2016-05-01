--1. compute the avg score by category & entry
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


group_category_entry  = GROUP raw BY (category,entry_name);


avg_score = FOREACH group_category_entry
{

	GENERATE group.category AS category, group.entry_name AS entry,  ROUND_TO(AVG(raw.score),4);
}


STORE avg_score INTO 'task8' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run task8.pig;
grunt> fs -getmerge task8/ category_entry_avg.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/