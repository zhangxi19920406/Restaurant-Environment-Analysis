use income;

drop table if exists YelpRating_Pay;
drop table if exists YelpHighRating_Pay;
create table YelpRating_Pay as
select r.zipcode, category, count, avg, avg_income, tol_job
from ratingzipcode r join AvgPayment a on r.zipcode = a.zipcode
order by zipcode;

create table YelpHighRating_Pay as
select hr.zipcode, category, count, avg_income, tol_job
from highratingzipcode hr join AvgPayment a on hr.zipcode = a.zipcode
order by zipcode;

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
