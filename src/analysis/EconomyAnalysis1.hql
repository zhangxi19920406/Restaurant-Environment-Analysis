use income;

drop table if exists Payment_raw;
drop table if exists Payment;
drop table if exists AvgPayment;
drop table if exists MTAentrance;
drop table if exists MTAtotal;
drop table if exists MTA_Pay;
create table Payment
(
job string,
block int,
lot int,
fill_time string,
Est_income double,
Est_cost double,
zip string
)
row format delimited fields terminated by ','
stored as textfile;
load data local inpath '../data/payment/000000_0'
into table Payment;

create table AvgPayment as
SELECT zip AS zipcode, AVG(Est_income) avg_income, AVG(Est_cost) avg_cost, COUNT(job) tol_job
from Payment
group by zip
order by zip;

create table MTAentrance 
(zipcode string, entrance string, Latitude double, longtitude double)
row format delimited fields terminated by ','
stored as textfile;

load data local inpath '../data/MTAinput/MTAentrance.csv'
into table MTAentrance;

create table MTAtotal as
SELECT zipcode, COUNT(entrance) total_en, COUNT(DISTINCT entrance) total_sta
from MTAentrance
group by zipcode
order by zipcode;

create table MTA_Pay as
select m.zipcode, total_en, total_sta, avg_income, tol_job
from MTAtotal m join AvgPayment a on (m.zipcode = a.zipcode)
order by m.zipcode;
order by m.zipcode;

insert overwrite local directory '../data/avg_payment'
row format delimited fields terminated by ','
select zipcode, avg_income, avg_cost, tol_job
from AvgPayment 
order by zipcode;

insert overwrite local directory '../data/MTAtotal'
row format delimited fields terminated by ','
select zipcode, total_en, total_sta
from MTAtotal
order by zipcode;

insert overwrite local directory "../data/MTA_Pay"
row format delimited fields terminated by ','
select MTA_Pay.*
from MTA_Pay
order by zipcode;
