REGISTER ./pigtmp/tutorial.jar;

raw = LOAD '/user/chenhuichun/MTAinput/zipcode.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(zipcode:int, 
Station_Name:chararray, 
Corner:chararray, 
Latitude:double, 
Longitude:double);


zipcode_sort = ORDER raw BY zipcode ASC;
zipcode_clean = FILTER zipcode_sort BY zipcode IS NOT NULL ;

zipcode_concat = FOREACH zipcode_clean GENERATE zipcode, CONCAT(Station_Name,'-', Corner) as entrance, Latitude, Longitude ;
--B = FOREACH A GENERATE CONCAT(cc,'-',bb,'-',mm)

STORE zipcode_concat INTO 'zipcode_clean' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');

/*
grunt> run zipcode_clean.pig;
grunt> fs -getmerge zipcode_clean/ MTAentrance.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/