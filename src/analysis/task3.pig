--1. filter out the distance more than 1 mile
REGISTER ./pigtmp/tutorial.jar;

raw = LOAD '/user/chenhuichun/Input/Fulltable_dis.csv' USING PigStorage(',') AS  --/user/chenhuichun/Input/
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

clean_dis = FILTER raw BY distance<0.5;

STORE clean_dis INTO 'task3' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS');
/*
grunt> run task3.pig;
grunt> fs -getmerge task3/ Fulltable_dis_h.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/

