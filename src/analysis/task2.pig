--compute distance between entrance and each store.

REGISTER ./pigtmp/tutorial.jar;

raw = LOAD 'task1.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(entry_name:chararray,--entrance info
entry_lat:chararray,
entry_long:chararray,
entry_zp: int,
store_name:chararray,
category:chararray,--store info
rating:double,
store_lat:double, 
store_long:double,
store_zp:int); 

add_dis = FOREACH raw GENERATE entry_name, entry_lat, entry_long, entry_zp, store_name, category,rating, 
((entry_lat-store_lat)^2 + (entry_long-store_long)^2 )^0.5 AS distance,
store_lat, store_long, store_zp;


STORE add_dist INTO 'task2' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run task2.pig;
grunt> fs -getmerge task2/ task2.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/