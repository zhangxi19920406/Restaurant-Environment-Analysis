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

-- 0.limited data in Manhattan
manhattan= FILTER raw BY (Latitude > 40.68392 ) AND (Latitude < 40.877645 ) --10004, 10034
						AND(Longitude > -74.019603) AND(Longitude < -73.913748) ; --10280, 10044

--1. Central Harlem: 10026, 10027, 10030, 10037, 10039
zipcode_10026 =  FILTER manhattan BY (Latitude > 40.79691) AND (Latitude < 40.807546)  
				AND (Longitude > -73.962475 ) AND(Longitude < -73.944667) ;
add_10026 = FOREACH zipcode_10026 GENERATE '10026' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10027 = FILTER manhattan BY (Latitude > 40.803047 ) AND (Latitude < 40.822108)  
				AND (Longitude > -73.9659 ) AND(Longitude < -73.940404) ;
add_10027 = FOREACH zipcode_10027 GENERATE '10027' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10030 = FILTER manhattan BY (Latitude > 40.812791 ) AND (Latitude < 40.824032)  
				AND (Longitude > -73.948677 ) AND(Longitude < -73.936227 ) ;
add_10030 = FOREACH zipcode_10027 GENERATE '10027' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10037 = FILTER manhattan BY (Latitude > 40.806668 ) AND (Latitude < 40.819697 )  
				AND (Longitude > -73.943398 ) AND(Longitude < -73.933219) ;
add_10037 = FOREACH zipcode_10037 GENERATE '10037' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10039 = FILTER manhattan BY (Latitude > 40.817914) AND (Latitude < 40.846576)   
				AND (Longitude > -73.943506 ) AND(Longitude < -73.929303) ;
add_10039 = FOREACH zipcode_10039 GENERATE '10039' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

--2. Chelsea and Clinton	10001, 10011, 10018, 10019, 10020, 10036
zipcode_10001 = FILTER manhattan BY (Latitude > 40.743451) AND (Latitude < 40.759686)  
				AND (Longitude > -74.00828) AND(Longitude < -73.984076) ;
add_10001 = FOREACH zipcode_10001 GENERATE '10001' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10011  = FILTER manhattan BY (Latitude > 40.731043 ) AND (Latitude < 40.756703)  
				AND (Longitude > -74.012359 ) AND(Longitude <  -73.990798 ) ;
add_10011 = FOREACH zipcode_10011 GENERATE '10011' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10018  = FILTER manhattan BY (Latitude > 40.749102 ) AND (Latitude < 40.762208)  
				AND (Longitude > -74.007203 ) AND(Longitude < -73.981822 ) ;
add_10018 = FOREACH zipcode_10018 GENERATE '10018' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10019  = FILTER manhattan BY (Latitude > 40.758645 ) AND (Latitude < 40.773325)  
				AND (Longitude > -74.003477) AND(Longitude < -73.973015 ) ;
add_10019 = FOREACH zipcode_10019 GENERATE '10019' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10020  = FILTER manhattan BY (Latitude > 40.757284 ) AND (Latitude < 40.761094)  
				AND (Longitude >  -73.98373 ) AND(Longitude < -73.977201 ) ;
add_10020 = FOREACH zipcode_10020 GENERATE '10020' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10036  = FILTER manhattan BY (Latitude > 40.752197 ) AND (Latitude < 40.765489)  
				AND (Longitude > -74.001622 ) AND(Longitude < -73.978116 ) ;
add_10036 = FOREACH zipcode_10036 GENERATE '10036' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

--3. East Harlem	10029, 10035
zipcode_10029  = FILTER manhattan BY (Latitude > 40.78265 ) AND (Latitude < 40.800665 )  
				AND (Longitude > -73.955778 ) AND(Longitude < -73.931094 ) ;
add_10029 = FOREACH zipcode_10029 GENERATE '10029' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10035 = FILTER manhattan BY (Latitude > 40.78092) AND (Latitude < 40.809582 )  
				AND (Longitude >  -73.946462 ) AND(Longitude < -73.913748 ) ;
add_10035 = FOREACH zipcode_10035 GENERATE '10035' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

--4.Gramercy Park and Murray Hill	10010, 10016, 10017, 10022
zipcode_10010  = FILTER manhattan BY (Latitude > 40.73231) AND (Latitude < 40.745421 )  
				AND (Longitude > -73.994028 ) AND(Longitude <  -73.971566 ) ;
add_10010 = FOREACH zipcode_10010 GENERATE '10010' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10016  = FILTER manhattan BY (Latitude > 40.73801) AND (Latitude < 40.752197 )  
				AND (Longitude > -73.987746 ) AND(Longitude < -73.968192 ) ;
add_10016 = FOREACH zipcode_10016 GENERATE '10016' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10017  = FILTER manhattan BY (Latitude > 40.747251) AND (Latitude < 40.757912 )  
				AND (Longitude > -73.981822 ) AND(Longitude < -73.964715 ) ;
add_10017 = FOREACH zipcode_10017 GENERATE '10017' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10022  = FILTER manhattan BY (Latitude > 40.751717 ) AND (Latitude < 40.764898 )  
				AND (Longitude >  -73.977655 ) AND(Longitude < -73.958811 ) ;
add_10022 = FOREACH zipcode_10022 GENERATE '10022' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

--5. Greenwich Village and Soho	10012, 10013, 10014
zipcode_10012  = FILTER manhattan BY (Latitude > 40.719867) AND (Latitude < 40.731706 )  
				AND (Longitude > -74.004575 ) AND(Longitude < -73.991794 ) ;
add_10012 = FOREACH zipcode_10012 GENERATE '10012' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10013  = FILTER manhattan BY (Latitude > 40.713468) AND (Latitude < 40.727557)  
				AND (Longitude > -74.016381  ) AND(Longitude < -73.994035 ) ;
add_10013 = FOREACH zipcode_10013 GENERATE '10013' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

zipcode_10014 = FILTER manhattan BY (Latitude > 40.724266 ) AND (Latitude < 40.742873  )  
				AND (Longitude > -74.01599 ) AND(Longitude < -73.999555 ) ;
add_10014 = FOREACH zipcode_10014 GENERATE '10014' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

-- -- ▲ template: 
-- -- zipcode_100  = FILTER manhattan BY (Latitude > ) AND (Latitude <  )  
-- -- 				AND (Longitude >  ) AND(Longitude <  ) ;
-- -- add_100 = FOREACH zipcode_100 GENERATE '100' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

-- --6. Lower Manhattan	10004, 10005, 10006, 10007, 10038, 10280
-- zipcode_10004 = FILTER manhattan BY (Latitude > 40.68392) AND (Latitude < 40.709044)  
-- 				AND (Longitude > -74.047285) AND(Longitude < -73.995138) ;
-- add_10004 = FOREACH zipcode_10004 GENERATE '10004' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

-- zipcode_10005 = FILTER manhattan BY (Latitude > ) AND (Latitude < )  
-- 				AND (Longitude > ) AND(Longitude < ) ;
-- add_10005 = 

-- zipcode_10006 =FILTER manhattan BY (Latitude > ) AND (Latitude < )  
-- 				AND (Longitude > ) AND(Longitude < ) ;
-- add_10006 = 

-- zipcode_10007 = FILTER manhattan BY (Latitude > ) AND (Latitude < )  
-- 				AND (Longitude > ) AND(Longitude < ) ;
-- add_10007 = 

-- --7.Lower East Side	10002, 10003, 10009
-- zipcode_10002 = FILTER manhattan BY (Latitude > 40.709148) AND (Latitude < 40.724136)  
-- 				AND (Longitude > -73.997504) AND(Longitude < -73.973635) ;
-- add_10002 = FOREACH zipcode_10002 GENERATE '10002' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

-- zipcode_10003 = FILTER manhattan BY (Latitude > 40.722933) AND (Latitude < 40.739673)  
-- 				AND (Longitude > -73.999604) AND(Longitude < -73.979864) ;
-- add_10003 = FOREACH zipcode_10003 GENERATE '10003' AS zipcode, Station_Name, Latitude, Longitude, Corner ;

-- 8. Upper East Side	10021, 10028, 10044, 10065, 10075, 10128
-- 9. Upper West Side	10023, 10024, 10025
-- 10.Inwood and Washington Heights	10031, 10032, 10033, 10034, 10040



zipcode_mix = UNION add_10026, add_10027, add_10030, add_10037, add_10039, 
					add_10001, add_10011, add_10018, add_10019, add_10020, add_10036,
					add_10029, add_10035, 
					add_10010, add_10016, add_10017, add_10022,
					add_10012, add_10013, add_10014 ;


STORE zipcode_mix INTO 'zipcode' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run salesreport.pig;
grunt> fs -getmerge myreport/ bigsales.txt;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/