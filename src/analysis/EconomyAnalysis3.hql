use income;

drop table if exists YelpRating_Pay;
drop table if exists YelpHighRating_Pay;
drop table if exists TotRatingZipCode;
drop table if exists YelpIncomeSummary;
create table YelpRating_Pay as
select r.zipcode, category, count, avg, avg_income, tol_job
from ratingzipcode r join AvgPayment a on r.zipcode = a.zipcode
order by zipcode;

create table YelpHighRating_Pay as
select hr.zipcode, category, count, avg_income, tol_job
from highratingzipcode hr join AvgPayment a on hr.zipcode = a.zipcode
order by zipcode;

create table TotRatingZipCode
(
zipcode string,
category string,
count bigint,
average double,
totRating double
)
row format delimited fields terminated by ','
stored as textfile;
load data local inpath '../data/input/totRatingZipCode.csv'
into table TotRatingZipCode;

create table YelpIncomeSummary as
select y.*, a.avg_income, a.tol_Job, a.tol_ComArea, a.tol_ResArea
from
(
select tr.*, thr.totHighCount from
(select zipcode, sum(count) as totCount, sum(totRating) as totRating from TotRatingZipCode group by zipcode) as tr
join 
(select zipcode, sum(count) as totHighCount from highRatingZipCode where count is not NULL group by zipcode) as thr
on tr.zipcode = thr.zipcode) as y
join AvgPay_Area as a on y.zipcode = a.zipcode
order by y.zipcode;

insert overwrite local directory "../data/YelpRating_Pay"
row format delimited fields terminated by ','
select YelpRating_Pay.*
from YelpRating_Pay
order by zipcode;

insert overwrite local directory "../data/YelpHighRating_Pay"
row format delimited fields terminated by ','
select YelpHighRating_Pay.*
from YelpHighRating_Pay
order by zipcode;

INSERT OVERWRITE LOCAL DIRECTORY '../data/YelpIncomeSummay'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
select YelpIncomeSummary.*
from YelpIncomeSummary;
