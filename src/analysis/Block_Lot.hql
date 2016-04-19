CREATE DATABASE IF NOT EXISTS income;
USE income;
drop table if exists PlutoInput;
CREATE TABLE PlutoInput (Borough string,Block string,Lot string,CD string,CT2010 string,CB2010 string,SchoolDist string,Council string,ZipCode string,FireComp string,PolicePrct string,HealthArea string,Address string,ZoneDist1 string,ZoneDist2 string,ZoneDist3 string,ZoneDist4 string,Overlay1 string,Overlay2 string,SPDist1 string,SPDist2 string,LtdHeight string,AllZoning1 string,AllZoning2 string,SplitZone string,BldgClass string,LandUse string,Easements string,OwnerType string,OwnerName string,LotArea string,BldgArea string,ComArea string,ResArea string,OfficeArea string,RetailArea string,GarageArea string,StrgeArea string,FactryArea string,OtherArea string,AreaSource string,NumBldgs string,NumFloors string,UnitsRes string,UnitsTotal string,LotFront string,LotDepth string,BldgFront string,BldgDepth string,Ext string,ProxCode string,IrrLotCode string,LotType string,BsmtCode string,AssessLand string,AssessTot string,ExemptLand string,ExemptTot string,YearBuilt string,BuiltCode string,YearAlter1 string,YearAlter2 string,HistDist string,Landmark string,BuiltFAR string,ResidFAR string,CommFAR string,FacilFAR string,BoroCode string,BBL string,CondoNo string,Tract2010 string,XCoord string,YCoord string,ZoneMap string,ZMCode string,Sanborn string,TaxMap string,EDesigNum string,APPBBL string,APPDate string,PLUTOMapID string,Version string) row format delimited fields terminated by ',' stored as textfile;
LOAD DATA LOCAL INPATH '../data/PlutoInput.csv' OVERWRITE INTO TABLE PlutoInput;

USE income;
set mapred.queue.name=queue3;

INSERT OVERWRITE LOCAL DIRECTORY '../data/Block_Zip'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
select Borough, cast(Block as int), cast(Lot as int), ZipCode
from PlutoInput
where Borough = "MN" AND ZipCode is not NULL AND ZipCode <> "";
