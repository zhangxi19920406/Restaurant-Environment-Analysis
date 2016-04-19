# hdfs dfs -put yelp.csv /user/cloudera/project/input/yelp/
# hdfs dfs -put zipcode.csv /user/cloudera/project/input/zipcodeList/

# hdfs dfs -put paid.csv /user/cloudera/project/input/income/DOB_Job_filling/
# hive

DROP TABLE yelp;
DROP TABLE zipcode;

DROP TABLE job_paid;

CREATE EXTERNAL TABLE yelp 
(id string, zipcode string, geo_accuracy float, latitude float, longtitude float, categories string, rating float) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/yelp';

CREATE EXTERNAL TABLE zipcode 
(zipcode string, neighborhood string) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/zipcodeList';

CREATE EXTERNAL TABLE job_paid 
(Job_id string, block int, lot int, filling_date string, Est_income double, Est_cost double, zipcode string) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/income/DOB_Job_filling';
