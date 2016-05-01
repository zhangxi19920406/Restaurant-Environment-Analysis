--1. Compute the value of each entry-store
-- formula: 0.5*rating + 0.5*distance, full socre:10
--2. cadidate must exceed score 6.0

REGISTER ./pigtmp/tutorial.jar;

raw = LOAD 'Fulltable_dis_h.csv' USING PigStorage(',') AS  --/user/chenhuichun/Input/
(MTA_zipcode:int, --MTA info
entry_name:chararray, 
entry_lati:double, 
entry_longi:double,
store_zipcode:int, --store info
store_name:chararray,
store_lati:double, 
store_longi:double,
category:chararray,
rating:double,
store_neighbor:chararray,
distance:double); 

add_score = FOREACH raw GENERATE 
MTA_zipcode, entry_name, entry_lati, entry_longi,--MTA info
store_zipcode, store_neighbor, store_name, store_lati, store_longi, category, rating, distance, --store info
(0.5* (rating/5.0) + 0.5*(1-distance))*10 AS score;

filter_score = FILTER add_score BY score > 6.0;

STORE filter_score INTO 'task4' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' );

/*
grunt> run task4.pig;
grunt> fs -getmerge task4/ Fulltable_score_h_6.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/