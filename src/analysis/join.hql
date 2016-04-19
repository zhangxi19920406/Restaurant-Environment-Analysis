use income;
drop table if exists Job_zip;
create table Job_zip
( 
Job string,
borough string,
block int,
lot int,
fill_time string,
Est_income string,
Est_cost string
)
row format delimited fields terminated by ','
stored as textfile;

load data local inpath "../data/Job_zip/000000_0"
into table Job_zip;

drop table if exists Block_Zip;
create table Block_Zip
(
borough string,
block int,
lot int,
zipcode string
)
row format delimited fields terminated by ','
stored as textfile;

load data local inpath "../data/Block_Zip/000000_0"
into table Block_Zip;

insert overwrite local directory "../data/join"
row format delimited fields terminated by ','
select Job, d.block, d.lot, fill_time, Est_income, Est_cost, zipcode
from Job_zip d left join Block_Zip p on (d.block = p.block AND d.lot = p.lot)
order by zipcode;
