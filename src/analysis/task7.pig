--zipcode/neighbor to avg # of score above 6.0

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

group_zipcode = GROUP raw BY store_neighbor;

avg_candiate = FOREACH group_zipcode GENERATE group AS neighbor , ROUND_TO(AVG(raw.score),4) AS avg_score; --neighbor

STORE avg_candiate INTO 'task7' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run task6.pig;

		fs -getmerge task7/ neighbor_avgscore.csv;
		fs -getmerge task7/ zipcode_avgscore.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/