CREATE DATABASE IF NOT EXISTS income;
USE income;
drop table if exists DOB_Job_Application_Filings;
CREATE TABLE DOB_Job_Application_Filings (Job string,Doc string,Borough string,House string,StreetName string,Block string,Lot string,Bin string,JobType string,JobStatus string,JobStatusDescrp string,LatestActionDate string,BuildingType string,CommunityBoard string,Cluster string,Landmarked string,AdultEstab string,LoftBoard string,CityOwned string,Little_e string,PCFiled string,eFilingFiled string,Plumbing string,Mechanical string,Boiler string,FuelBurning string,FuelStorage string,Standpipe string,Sprinkler string,FireAlarm string,Equipment string,FireSuppression string,CurbCut string,Other string,OtherDescription string,Applicant_FirstName string,Applicant_LastName string,Applicant_ProfessionalTitle string,Applicant_License string,Professional_Cert string,PreFilingDate string,Paid string,FullyPaid string,Assigned string,Approved string,FullyPermitted string,InitialCost string,TotalEstFee string,FeeStatus string,ExistingZoningSqft string,ProposedZoningSqft string,HorizontalEnlrgmt string,VerticalEnlrgmt string,EnlargementSQFootage string,StreetFrontage string,ExistingNoofStories string,ProposedNoofStories string,ExistingHeight string,ProposedHeight string,ExistingDwellingUnits string,ProposedDwellingUnits string,ExistingOccupancy string,ProposedOccupancy string,SiteFill string,ZoningDist1 string,ZoningDist2 string,ZoningDist3 string,SpecialDistrict1 string,SpecialDistrict2 string,OwnerType string,NonProfit string,Owner_FirstName string,Owner_LastName string,Owner_BusinessName string,Owner_HouseNumber string,Owner_HouseStreetName string,City string,State string,Zip string,OwnerPhone string,JobDescription string,DOBRunDate string) row format delimited fields terminated by ',' stored as textfile;
LOAD DATA LOCAL INPATH '../data/input.csv' OVERWRITE INTO TABLE DOB_Job_Application_Filings;

USE income;
set mapred.queue.names=queue3;


INSERT OVERWRITE LOCAL DIRECTORY '../data/Job_zip'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
select Job, Borough, cast(Block as int), cast(Lot as int), Paid, InitialCost, TotalEstFee
from DOB_Job_Application_Filings
where Borough = "MANHATTAN" AND Paid is not NULL AND Paid <> '';
