--1. Compute the value of each entry-store
--formula: 0.5*rating + 0.5*distance

REGISTER ./pigtmp/tutorial.jar;

raw = LOAD 'task1.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(entry_name:chararray,--entrance info
entry_lat:chararray,
entry_long:chararray,
entry_zp: int,
store_name:chararray,
category:chararray,--store info
rating:double,
distance: double,
store_lat:double, 
store_long:double,
store_zp:int); 

add_value = FOREACH raw GENERATE entry_name, entry_lat, entry_long, entry_zp, store_name, category,rating, 
distance, store_lat, store_long, store_zp, 
(0.5*rating + 0.5*distance) AS value;


STORE add_value INTO 'task3' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');

/*
grunt> run task3.pig;
grunt> fs -getmerge task3/ task3.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/