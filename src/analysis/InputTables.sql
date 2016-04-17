# hdfs dfs -put yelp.csv /user/cloudera/project/input/yelp/
# hdfs dfs -put zipcode.csv /user/cloudera/project/input/zipcodeList/
# hive

DROP TABLE yelp;
DROP TABLE zipcode;

CREATE EXTERNAL TABLE yelp 
(id string, zipcode string, geo_accuracy float, latitude float, longtitude float, categories string, rating float) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/yelp';

CREATE EXTERNAL TABLE zipcode 
(zipcode string, neighborhood string) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/zipcodeList';