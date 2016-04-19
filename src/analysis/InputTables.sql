# hdfs dfs -put yelp.csv /user/cloudera/project/input/yelp/
# hdfs dfs -put zipcode.csv /user/cloudera/project/input/zipcodeList/
# hdfs dfs -put category.csv /user/cloudera/project/input/category/
# hdfs dfs -put paid.csv /user/cloudera/project/input/income/DOB_Job_filling/
# hive

DROP TABLE yelp;
DROP TABLE zipcode;
DROP TABLE categories;
DROP TABLE manhattanyelp;
DROP TABLE job_paid;

CREATE EXTERNAL TABLE yelp 
(id string, zipcode string, geo_accuracy float, latitude float, longtitude float, category string, rating float) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/yelp';

CREATE EXTERNAL TABLE zipcodes
(zipcode string, neighborhood string) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/zipcodeList';

CREATE EXTERNAL TABLE categories
(category string) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/category';

CREATE TABLE manhattanyelp AS 
SELECT yelp.*, zipcodes.neighborhood AS neighborhood FROM yelp, zipcodes
WHERE yelp.zipcode = zipcodes.zipcode;

CREATE EXTERNAL TABLE job_paid 
(Job_id string, block int, lot int, filling_date string, Est_income double, Est_cost double, zipcode string) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/income/DOB_Job_filling';
