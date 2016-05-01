use income;

drop table if exists TotRatingZipCode;
drop table if exists YelpIncomeSummary;
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

INSERT OVERWRITE LOCAL DIRECTORY '../data/YelpIncomeSummay'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
select YelpIncomeSummary.*
from YelpIncomeSummary;
