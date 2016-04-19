--1. Group by category & Find max value under each category.

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
store_zp:int
value:double); 


group_category = GROUP add_value BY category;
category_max = FOREACH group_category GENERATE 
group_category.entry_name,
group_category.entry_lat,
group_category.entry_long,
group_category.entry_zp,
group_category.store_name,
group,
group_category.store_lat, 
group_category.store_long,
group_category.store_zp,
MAX(group_category.value);

STORE category_max INTO 'task4' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');

/*
grunt> run task3.pig;
grunt> fs -getmerge task3/ task3.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/