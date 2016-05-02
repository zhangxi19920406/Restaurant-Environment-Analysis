# Restaurant-Environment-Analysis

The Analysis of the Restaurant Business Status and Surrounding Environment in Manhattan

In the paper, it is aimed to seek the the restaurants’ business status with their surrounding environment. The dataset area of the research is limited in Manhattan, New York. And the surrounding environment are considered as the traffic and economic conditions, which chosen as Metro data and average salary of company positions. All the restaurants’ business data status is come form Yelp, besides that the Metro data and salary data are collected from MTA and New York City Open Data. Map Reduce and Hive are used to process and mine all the data sets. 

Keywords
Analytics, Yelp, Rating, Surrounding Environment

1. Data ETL and API in /api/ directory: <br />
  (a) MTA file: "zipcode.pig" & "zipcode_clean.pig" for filtering out unnessary attributes and locating in Manhhatan area. <br />
  (b) The Yelp API runner and reformat runner are built in the main runner of the JAVA project. <br />
  (c) job: "java" file contains a java program for removing unexpected noise in the raw datasets. "script" file contains 4 hive scripts for loading and profiling data from two datasets. "udf" file contains 2 hive user defined function to adjust input type while loading data. <br />

2. Analysis in /analysis/ directory: <br />
  (a) "task1.pig ~ task9.pig" by order, run through pig with HDFS to compute the good candidates around each entrances. <br />
  (b) The InputTables.sql is run in Hive for input the table for analysis. <br />
  (c) The RatingAnalysis.sql is run to get the rating analysis result. <br />
  (d) The EconomyAnalysis1, 2, 3 files are Hive scripts to get tables containing the relations between Yelp, MTA and surrounding economic conditions from basic datasets after the ETL process. <br /> 
