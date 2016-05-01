-- Sort the avg score by category & entry
raw = LOAD '/user/chenhuichun/Input/category_entry_avg_5.csv' USING PigStorage(',') AS  --/user/chenhuichun/Input/
(category: chararray,
	entry: chararray,
	count:int,
	avg_score: double); 

group_category = GROUP raw BY category;


order_avg = FOREACH group_category 
{
	projected = FOREACH raw GENERATE entry, count, avg_score;
	tmp = DISTINCT projected;
	ordered = ORDER tmp BY avg_score DESC;
	GENERATE group AS category, ordered AS row;
}

temp = FOREACH order_avg GENERATE category,FLATTEN(row);

STORE temp INTO 'task9' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');



/*
grunt> run task9.pig;
grunt> fs -getmerge task9/ category_entry_avg_5_sort.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/