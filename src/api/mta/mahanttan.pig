REGISTER ./pigtmp/tutorial.jar;

raw = LOAD 'StationEntrances.csv' USING PigStorage(',') AS 
(Division:chararray,
Line:chararray, 	
Station_Name:chararray, 
Station_Latitude:DOUBLE, 
Station_Longitude:DOUBLE,  	
Route_1:chararray, 
Route_2:chararray, 
Route_3:chararray, 
Route_4:chararray, 
Route_5:chararray, 
Route_6:chararray, 
Route_7:chararray, 
Route_8:chararray, 	
Route_9:chararray, 
Route_10:chararray, 	
Route_11:chararray, 	
Entrance_Type:chararray, 	
Entry:chararray,  	
Exit_Only:chararray, 	
Vending:chararray, 
Staffing:chararray, 	
Staff_Hours:chararray,
ADA:chararray, 	
ADA_Notes:chararray, 
Free_Crossover:chararray, 
North_South_Street:chararray, 
East_West_Street:chararray, 	
Corner:chararray, 
Latitude:DOUBLE, 	
Longitude:DOUBLE);


manhattan= FILTER raw BY (Latitude > 40.68392 ) AND (Latitude < 40.877645 ) --10004, 10034
						AND(Longitude > -74.019603) AND(Longitude < -73.913748) ; --10280, 10044

clean = FOREACH manhattan GENERATE Station_Name, Latitude, Longitude, Corner ;

STORE clean INTO 'manhattan' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');

								