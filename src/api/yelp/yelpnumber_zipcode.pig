--compute the number of restaurants by each zipcode
--load data:
yelp_manhattan = LOAD '/user/chenhuichun/MTAinput/yelp_manhattan.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(zipcode:int,
store_name:chararray, 
latitude:double, 
longitude:double,
category:chararray,
rating:double,
neighborhood:chararray);


group_zipcode = GROUP yelp_manhattan BY zipcode;
sum_zipcode = FOREACH group_zipcode GENERATE group AS zipcode, COUNT(yelp_manhattan.zipcode) AS sum ;

STORE sum_zipcode INTO 'yelpnumber_zipcode' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS', 'WRITE_OUTPUT_HEADER' );

/*
grunt> run yelpnumber_zipcode.pig;
grunt> fs -getmerge yelpnumber_zipcode/ yelpnumber_zipcode.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/								

