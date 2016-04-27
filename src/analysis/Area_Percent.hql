use income;

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

INSERT OVERWRITE LOCAL DIRECTORY '../data/AreaPercent'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
select AreaPercent.*
from AreaPercent;