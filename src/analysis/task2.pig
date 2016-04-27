--compute distance between entrance and each store.
--using Haversine formula https://en.wikipedia.org/wiki/Haversine_formula

REGISTER  /Users/chenhuichun/Desktop/0411project/workspace/apache-datafu-incubating-sources-1.3.0/datafu-pig/build/libs/datafu-pig-incubating-1.3.0.jar;
--https://datafu.incubator.apache.org/docs/quick-start.html
REGISTER ./pigtmp/tutorial.jar;

Fulltable = LOAD '/user/chenhuichun/Input/Fulltable.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
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
store_neighbor:chararray);



Fulltable_dis = FOREACH Fulltable GENERATE 
MTA_zipcode, entry_name, entry_lati, entry_longi,--MTA info
store_zipcode, store_name, store_lati, store_longi, category, rating, store_neighbor, --store info
datafu.pig.geo.HaversineDistInMiles(entry_lati, entry_longi, store_lati, store_longi) AS distance;

-- SQRT( (entry_lati- store_lati)*(entry_lati- store_lati)
-- 	+ (entry_longi- store_longi)*((entry_longi- store_longi) ) AS distance; 


STORE Fulltable_dis INTO 'task2' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS');
/*
grunt> run task2.pig;
grunt> fs -getmerge task2/ Fulltable_dis.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/