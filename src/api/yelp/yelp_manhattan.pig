--Ristriced the restaurants in Manhattan by JOIN
yelp = LOAD '/user/chenhuichun/MTAinput/yelp.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(store_name:chararray, 
zipcode:int,
geo_accuracy:double,  
latitude:double, 
longitude:double,
category:chararray,
rating:double);

zipcodelist = LOAD '/user/chenhuichun/MTAinput/zipcodeList.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(zipcode_number:int, 
neighborhood:chararray);

categorylist = LOAD '/user/chenhuichun/MTAinput/yelp_category.csv' USING PigStorage(',') AS  --/user/chenhuichun/MTAinput/zipcode.csv
(category:chararray);


--1. clean yelp.csv
yelp_clean = FOREACH yelp GENERATE zipcode, store_name, latitude, longitude, category, rating ; 


--2. Join zipcodelist & clean more attributes
yelp_zipcode = JOIN yelp_clean BY zipcode, zipcodelist BY zipcode_number;
-- yelp_manhattan= FILTER raw_clean BY (latitude > 40.68392 ) AND (latitude < 40.877645 ) --10004, 10034
-- 						AND(longitude > -74.019603) AND(longitude < -73.913748) ; --10280, 10044

join_zipcode = FOREACH yelp_zipcode GENERATE 
yelp_clean::zipcode, yelp_clean::store_name, yelp_clean::latitude, yelp_clean::longitude, yelp_clean::category, yelp_clean::rating,
zipcodelist::neighborhood ; 

--3. Join category & clean more attributes
join_category = JOIN join_zipcode BY category , categorylist BY category;

yelp_manhattan = FOREACH join_category GENERATE 
yelp_clean::zipcode, yelp_clean::store_name, yelp_clean::latitude, yelp_clean::longitude, yelp_clean::category, yelp_clean::rating,
zipcodelist::neighborhood; 


STORE yelp_manhattan INTO 'yelp_manhattan' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS', 'WRITE_OUTPUT_HEADER' );


/*
grunt> run yelp_manhattan.pig;
grunt> fs -getmerge yelp_manhattan/ yelp_manhattan.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/