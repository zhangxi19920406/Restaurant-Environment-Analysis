use income;

drop table if exists AreaMap;
drop table if exists AreaPercent;
drop table if exists YelpRating_Area;
drop table if exists YelpHighRating_Area;
drop table if exists MTA_Area;

create table AreaMap
(Borough string, Block int, Lot int, ZipCode string, LotArea bigint, ComArea bigint, ResArea bigint)
row format delimited fields terminated by ','
stored as textfile;

load data local inpath "../data/AreaMap/000000_0"
into table AreaMap;

create table AreaPercent as
select ZipCode as zipcode, sum(LotArea) tol_LotArea, sum(ComArea) tol_ComArea, sum(ResArea) tol_ResArea
from AreaMap
where ZipCode is not NULL and ZipCode <> ""
group by ZipCode
order by ZipCode;

create table YelpRating_Area as
select r.zipcode, category, count, avg, tol_LotArea, tol_ComArea, tol_ResArea
from ratingzipcode r join AreaPercent a on r.zipcode = a.zipcode
order by zipcode;

create table YelpHighRating_Area as
select hr.zipcode, category, count, tol_LotArea, tol_ComArea, tol_ResArea
from highratingzipcode hr join AreaPercent a on hr.zipcode = a.zipcode
order by zipcode;

create table MTA_Area as
select m.zipcode, total_en, total_sta, tol_LotArea, tol_ComArea, tol_ResArea
from MTAtotal m join AreaPercent a on (m.zipcode = a.zipcode)
order by m.zipcode;

create table AvgPay_Area as
SELECT av.zipcode, avg_income, avg_cost, tol_job, tol_LotArea, tol_ComArea, tol_ResArea
from AvgPayment av join AreaPercent ar on (av.zipcode = ar.zipcode) 
order by zipcode;

INSERT OVERWRITE LOCAL DIRECTORY '../data/AreaPercent'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
select AreaPercent.*
from AreaPercent;

insert overwrite local directory '../data/AvgPay_Area'
row format delimited fields terminated by ','
select AvgPay_Area.*
from AvgPay_Area
order by zipcode;

insert overwrite local directory "../data/MTA_Area"
row format delimited fields terminated by ','
select MTA_Area.*
from MTA_Area
order by zipcode;

insert overwrite local directory "../data/YelpRating_Area"
row format delimited fields terminated by ','
select YelpRating_Area.*
from YelpRating_Area
order by zipcode;

insert overwrite local directory "../data/YelpHighRating_Area"
row format delimited fields terminated by ','
select YelpHighRating_Area.*
from YelpHighRating_Area
order by zipcode;
