# Restaurant-Environment-Analysis

The Analysis of the Restaurant Business Status and Surrounding Environment in Manhattan

In the paper, it is aimed to seek the the restaurants’ business status with their surrounding environment. The dataset area of the research is limited in Manhattan, New York. And the surrounding environment are considered as the traffic and economic conditions, which chosen as Metro data and average salary of company positions. All the restaurants’ business data status is come form Yelp, besides that the Metro data and salary data are collected from MTA and New York City Open Data. Map Reduce and Hive are used to process and mine all the data sets. 

Keywords
Analytics, Yelp, Rating, Surrounding Environment

1. Data ETL and API in /api/ directory:
  (a)MTA: filter out unnessary data and locate in Manhhatan area for analysis.
  (b)The Yelp API runner and reformat runner are built in the main runner of the JAVA project.

2. Analysis in /analysis/ directory:
  (a) 9 files by order: task1.pig ~ task9.pig, run through pig with HDFS to locate the good candidates around each entrances.
  (b) The InputTables.sql is run in Hive for input the table for analysis.
  (c) The RatingAnalysis.sql is run to get the rating analysis result.
