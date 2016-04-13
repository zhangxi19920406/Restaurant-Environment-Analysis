REGISTER ./pigtmp/tutorial.jar;

raw = LOAD '/user/chenhuichun/MTAinput/StationEntrances.csv' USING PigStorage(',') AS 
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

--https://www.maptechnica.com/us-zip-code-boundary-map/zip/10001
-- 0.limited data in Manhattan
manhattan= FILTER raw BY (Latitude > 40.68392 ) AND (Latitude < 40.877645 ) --10004, 10034
						AND(Longitude > -74.019603) AND(Longitude < -73.913748) ; --10280, 10044
--
--1. Central Harlem: 10026, 10027, 10030, 10037, 10039
zipcode_10026 =  FILTER manhattan BY (Latitude > 40.79691) AND (Latitude < 40.807546)  
				AND (Longitude > -73.962475 ) AND(Longitude < -73.944667) ;
add_10026 = FOREACH zipcode_10026 GENERATE '10026' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10027 = FILTER manhattan BY (Latitude > 40.803047 ) AND (Latitude < 40.822108)  
				AND (Longitude > -73.9659 ) AND(Longitude < -73.940404) ;
add_10027 = FOREACH zipcode_10027 GENERATE '10027' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10030 = FILTER manhattan BY (Latitude > 40.812791 ) AND (Latitude < 40.824032)  
				AND (Longitude > -73.948677 ) AND(Longitude < -73.936227 ) ;
add_10030 = FOREACH zipcode_10027 GENERATE '10027' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10037 = FILTER manhattan BY (Latitude > 40.806668 ) AND (Latitude < 40.819697 )  
				AND (Longitude > -73.943398 ) AND(Longitude < -73.933219) ;
add_10037 = FOREACH zipcode_10037 GENERATE '10037' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10039 = FILTER manhattan BY (Latitude > 40.817914) AND (Latitude < 40.846576)   
				AND (Longitude > -73.943506 ) AND(Longitude < -73.929303) ;
add_10039 = FOREACH zipcode_10039 GENERATE '10039' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--2. Chelsea and Clinton	10001, 10011, 10018, 10019, 10020, 10036
zipcode_10001 = FILTER manhattan BY (Latitude > 40.743451) AND (Latitude < 40.759686)  
				AND (Longitude > -74.00828) AND(Longitude < -73.984076) ;
add_10001 = FOREACH zipcode_10001 GENERATE '10001' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10011  = FILTER manhattan BY (Latitude > 40.731043 ) AND (Latitude < 40.756703)  
				AND (Longitude > -74.012359 ) AND(Longitude <  -73.990798 ) ;
add_10011 = FOREACH zipcode_10011 GENERATE '10011' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10018  = FILTER manhattan BY (Latitude > 40.749102 ) AND (Latitude < 40.762208)  
				AND (Longitude > -74.007203 ) AND(Longitude < -73.981822 ) ;
add_10018 = FOREACH zipcode_10018 GENERATE '10018' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10019  = FILTER manhattan BY (Latitude > 40.758645 ) AND (Latitude < 40.773325)  
				AND (Longitude > -74.003477) AND(Longitude < -73.973015 ) ;
add_10019 = FOREACH zipcode_10019 GENERATE '10019' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10020  = FILTER manhattan BY (Latitude > 40.757284 ) AND (Latitude < 40.761094)  
				AND (Longitude >  -73.98373 ) AND(Longitude < -73.977201 ) ;
add_10020 = FOREACH zipcode_10020 GENERATE '10020' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10036  = FILTER manhattan BY (Latitude > 40.752197 ) AND (Latitude < 40.765489)  
				AND (Longitude > -74.001622 ) AND(Longitude < -73.978116 ) ;
add_10036 = FOREACH zipcode_10036 GENERATE '10036' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--3. East Harlem	10029, 10035
zipcode_10029  = FILTER manhattan BY (Latitude > 40.78265 ) AND (Latitude < 40.800665 )  
				AND (Longitude > -73.955778 ) AND(Longitude < -73.931094 ) ;
add_10029 = FOREACH zipcode_10029 GENERATE '10029' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10035 = FILTER manhattan BY (Latitude > 40.78092) AND (Latitude < 40.809582 )  
				AND (Longitude >  -73.946462 ) AND(Longitude < -73.913748 ) ;
add_10035 = FOREACH zipcode_10035 GENERATE '10035' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--4.Gramercy Park and Murray Hill	10010, 10016, 10017, 10022
zipcode_10010  = FILTER manhattan BY (Latitude > 40.73231) AND (Latitude < 40.745421 )  
				AND (Longitude > -73.994028 ) AND(Longitude <  -73.971566 ) ;
add_10010 = FOREACH zipcode_10010 GENERATE '10010' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10016  = FILTER manhattan BY (Latitude > 40.73801) AND (Latitude < 40.752197 )  
				AND (Longitude > -73.987746 ) AND(Longitude < -73.968192 ) ;
add_10016 = FOREACH zipcode_10016 GENERATE '10016' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10017  = FILTER manhattan BY (Latitude > 40.747251) AND (Latitude < 40.757912 )  
				AND (Longitude > -73.981822 ) AND(Longitude < -73.964715 ) ;
add_10017 = FOREACH zipcode_10017 GENERATE '10017' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10022  = FILTER manhattan BY (Latitude > 40.751717 ) AND (Latitude < 40.764898 )  
				AND (Longitude >  -73.977655 ) AND(Longitude < -73.958811 ) ;
add_10022 = FOREACH zipcode_10022 GENERATE '10022' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--5. Greenwich Village and Soho	10012, 10013, 10014
zipcode_10012  = FILTER manhattan BY (Latitude > 40.719867) AND (Latitude < 40.731706 )  
				AND (Longitude > -74.004575 ) AND(Longitude < -73.991794 ) ;
add_10012 = FOREACH zipcode_10012 GENERATE '10012' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10013  = FILTER manhattan BY (Latitude > 40.713468) AND (Latitude < 40.727557)  
				AND (Longitude > -74.016381  ) AND(Longitude < -73.994035 ) ;
add_10013 = FOREACH zipcode_10013 GENERATE '10013' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10014 = FILTER manhattan BY (Latitude > 40.724266 ) AND (Latitude < 40.742873  )  
				AND (Longitude > -74.01599 ) AND(Longitude < -73.999555 ) ;
add_10014 = FOREACH zipcode_10014 GENERATE '10014' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--6. Lower Manhattan	10004, 10005, 10006, 10007, 10038, 10280
zipcode_10004 = FILTER manhattan BY (Latitude > 40.68392) AND (Latitude < 40.709044)  
				AND (Longitude > -74.047285) AND(Longitude < -73.995138) ;
add_10004 = FOREACH zipcode_10004 GENERATE '10004' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10005 = FILTER manhattan BY (Latitude > 40.703064 ) AND (Latitude < 40.709294 )  
				AND (Longitude > -74.012508) AND(Longitude < -74.00456) ;
add_10005 = FOREACH zipcode_10005 GENERATE '10005' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10006 =FILTER manhattan BY (Latitude > 40.705871 ) AND (Latitude < 40.713623 )  
				AND (Longitude > -74.015956 ) AND(Longitude < -74.009988) ;
add_10006 = FOREACH zipcode_10006 GENERATE '10006' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10007 = FILTER manhattan BY (Latitude > 40.717114 ) AND (Latitude < 40.717114 )  
				AND (Longitude > -74.013597 ) AND(Longitude < -74.000455) ;
add_10007 = FOREACH zipcode_10007 GENERATE '10007' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10038 = FILTER manhattan BY (Latitude > 40.701689 ) AND (Latitude < 40.714451 )  
				AND (Longitude > -74.010542 ) AND(Longitude < -73.991777 ) ;
add_10038 = FOREACH zipcode_10038 GENERATE '10038' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10280 = FILTER manhattan BY (Latitude >	40.701256 ) AND (Latitude < 40.714767 )  
				AND (Longitude > -74.019603 ) AND(Longitude < -74.013597) ;
add_10280 = FOREACH zipcode_10280 GENERATE '10280' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--7.Lower East Side	10002, 10003, 10009
zipcode_10002 = FILTER manhattan BY (Latitude > 40.709148) AND (Latitude < 40.724136)  
				AND (Longitude > -73.997504) AND(Longitude < -73.973635) ;
add_10002 = FOREACH zipcode_10002 GENERATE '10002' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10003 = FILTER manhattan BY (Latitude > 40.722933) AND (Latitude < 40.739673)  
				AND (Longitude > -73.999604) AND(Longitude < -73.979864) ;
add_10003 = FOREACH zipcode_10003 GENERATE '10003' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10009 = FILTER manhattan BY (Latitude > 40.718612) AND (Latitude < 40.734975)  
				AND (Longitude > -73.988643) AND(Longitude < -73.971282) ;
add_10009 = FOREACH zipcode_10009 GENERATE '10009' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--8. Upper East Side	10021, 10028, 10044, 10065, 10075, 10128
zipcode_10021  = FILTER manhattan BY (Latitude > 40.758256) AND (Latitude < 40.775045 )  
				AND (Longitude > -73.968441 ) AND(Longitude < -73.947973 ) ;
add_10021 = FOREACH zipcode_10021 GENERATE '10021' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10028  = FILTER manhattan BY (Latitude > 40.770121) AND (Latitude < 40.782213 )  
				AND (Longitude > -73.96323 ) AND(Longitude < -73.944337) ;
add_10028 = FOREACH zipcode_10028 GENERATE '10028' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10044  = FILTER manhattan BY (Latitude > 40.749458) AND (Latitude < 40.772955 )  
				AND (Longitude > -73.961588 ) AND(Longitude < -73.940026 ) ;
add_10044 = FOREACH zipcode_10044 GENERATE '10044' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10065  = FILTER manhattan BY (Latitude > 40.759284 ) AND (Latitude < 	40.770517 )  
				AND (Longitude > -73.972553 ) AND(Longitude < -73.952308 ) ;
add_10065 = FOREACH zipcode_10065 GENERATE '10065' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10075  = FILTER manhattan BY (Latitude > 40.769441 ) AND (Latitude < 40.777677 )  
				AND (Longitude >  -73.965148 ) AND(Longitude < -73.94701 ) ;
add_10075 = FOREACH zipcode_10075 GENERATE '10075' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10128  = FILTER manhattan BY (Latitude > 40.773065 ) AND (Latitude < 40.787914 )  
				AND (Longitude > -73.959921  ) AND(Longitude < -73.937328 ) ;
add_10128 = FOREACH zipcode_10128 GENERATE '10128' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--9. Upper West Side	10023, 10024, 10025
zipcode_10023  = FILTER manhattan BY (Latitude > 40.768436 ) AND (Latitude < 40.783192 )  
				AND (Longitude > -73.990149 ) AND(Longitude < -73.974067 ) ;
add_10023 = FOREACH zipcode_10023 GENERATE '10023' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10024  = FILTER manhattan BY (Latitude > 40.778805 ) AND (Latitude < 40.818099)  
				AND (Longitude > -73.98814  ) AND(Longitude < -73.960687 ) ;
add_10024 = FOREACH zipcode_10024 GENERATE '10024' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10025  = FILTER manhattan BY (Latitude > 40.788476 ) AND (Latitude < 40.811264 )  
				AND (Longitude > -73.977092 ) AND(Longitude < -73.954966 ) ;
add_10025 = FOREACH zipcode_10025 GENERATE '10025' AS zipcode, Station_Name, Corner, Latitude, Longitude;

--10.Inwood and Washington Heights	10031, 10032, 10033, 10034, 10040
zipcode_10031  = FILTER manhattan BY (Latitude > 40.817221 ) AND (Latitude < 40.834326 )  
				AND (Longitude > -73.960007 ) AND(Longitude < -73.938588 ) ;
add_10031 = FOREACH zipcode_10031 GENERATE '10031' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10032  = FILTER manhattan BY (Latitude > 40.829083) AND (Latitude < 40.850459 )  
				AND (Longitude > -73.950279 ) AND(Longitude < -73.934671 ) ;
add_10032 = FOREACH zipcode_10032 GENERATE '10032' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10033  = FILTER manhattan BY (Latitude > 40.842958 ) AND (Latitude < 40.861594 )  
				AND (Longitude > -73.944882 ) AND(Longitude < -73.92216 ) ;
add_10033 = FOREACH zipcode_10033 GENERATE '10033' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10034  = FILTER manhattan BY (Latitude > 40.849755) AND (Latitude < 40.877645 )  
				AND (Longitude > -73.947005 ) AND(Longitude < -73.910587 ) ;
add_10034 = FOREACH zipcode_10034 GENERATE '10034' AS zipcode, Station_Name, Corner, Latitude, Longitude;

zipcode_10040  = FILTER manhattan BY (Latitude > 40.851863 ) AND (Latitude < 40.866336 )  
				AND (Longitude > -73.939012 ) AND(Longitude < -73.924385 ) ;
add_10040 = FOREACH zipcode_10040 GENERATE '10040' AS zipcode, Station_Name, Corner, Latitude, Longitude;



zipcode_mix = UNION add_10026, add_10027, add_10030, add_10037, add_10039, 			--1. Central Harlem	
					add_10001, add_10011, add_10018, add_10019, add_10020, add_10036, --2. Chelsea and Clinton	
					add_10029, add_10035, 												--3. East Harlem	
					add_10010, add_10016, add_10017, add_10022, 						--4. Gramercy Park and Murray Hill
					add_10012, add_10013, add_10014,									--5. Greenwich Village and Soho
					add_10004, add_10005, add_10006, add_10007, add_10038, add_10280,--6. Lower Manhattan
					add_10002, add_10003, add_10009, 							--7.Lower East Side
					add_10021, add_10028, add_10044, add_10065, add_10075, add_10128, --8. Upper East Side
					add_10023, add_10024, add_10025,								--9. Upper West Side	
					add_10031, add_10032, add_10033, add_10034, add_10040; 			--10.Inwood and Washington Heights	


STORE zipcode_mix INTO 'zipcode' USING org.apache.pig.piggybank.storage.CSVExcelStorage
								( ',', 'NO_MULTILINE' , 'WINDOWS' , 'WRITE_OUTPUT_HEADER');


/*
grunt> run salesreport.pig;
grunt> fs -getmerge zipcode_mix/ test.csv;

grunt> fs -ls; -- lists HDFS files 
grunt> sh ls; -- lists local files
*/