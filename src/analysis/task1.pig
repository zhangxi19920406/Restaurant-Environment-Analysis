--cross the 2 tables O(m*n)

REGISTER ./pigtmp/tutorial.jar;

MTAentrance = LOAD '/user/chenhuichun/Input/MTAentrance.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(zipcode:int, 
entry_name:chararray, 
entry_lati:double, 
entry_longi:double);

yelp_manhattan = LOAD '/user/chenhuichun/Input/yelp_manhattan.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(zipcode:int,
store_name:chararray,
store_lati:double, 
store_longi:double,
category:chararray,
rating:double,
store_neighbor:chararray);

Fulltable = CROSS MTAentrance, yelp_manhattan;

STORE Fulltable INTO 'task1' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS');
/*
grunt> run task1.pig;
grunt> fs -getmerge task1/ Fulltable.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/