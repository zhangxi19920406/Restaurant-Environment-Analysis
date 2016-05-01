--zipcode/neighbor to count # of score above 6.0

REGISTER ./pigtmp/tutorial.jar;

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

group_zipcode = GROUP raw BY store_zipcode; --store_neighbor;

count_candiate = FOREACH group_zipcode GENERATE group AS zipcode , COUNT($1) AS count; --neighbor

STORE count_candiate INTO 'task6' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run task6.pig;
grunt> fs -getmerge task6/ neighbor_count.csv; 
		fs -getmerge task6/ zipcode_count.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/