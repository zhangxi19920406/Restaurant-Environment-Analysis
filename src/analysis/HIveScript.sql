# hdfs dfs -put yelp.csv /user/cloudera/project/input/yelp/
# hive

DROP TABLE yelp;

CREATE EXTERNAL TABLE yelp 
(id string, zipcode string, geo_accuracy float, latitude float, longtitude float, categories string, rating float) 
row format delimited fields terminated by ',' 
location '/user/cloudera/project/input/yelp';