use income;

drop table if exists MTAentrance;
create table MTAentrance 
(zipcode string, entrance string, Latitude double, longtitude double)
row format delimited fields terminated by ','
stored as textfile;

load data local inpath '../data/MTAinput/MTAentrance.csv'
into table MTAentrance;

drop table if exists MTAtotal;
create table MTAtotal as
SELECT zipcode, COUNT(entrance) total_en, COUNT(DISTINCT entrance) total_sta
from MTAentrance
group by zipcode
order by zipcode;

insert overwrite local directory '../data/MTAtotal'
row format delimited fields terminated by ','
select zipcode, total_en, total_sta
from MTAtotal
order by zipcode;


