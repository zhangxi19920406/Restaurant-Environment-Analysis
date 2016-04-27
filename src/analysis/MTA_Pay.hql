use income;

drop table if exists MTA_Pay;
create table MTA_Pay as
select m.zipcode, total_en, total_sta, avg_income, tol_job
from MTAtotal m join AvgPayment a on (m.zipcode = a.zipcode)
order by m.zipcode;

insert overwrite local directory "../data/MTA_Pay"
row format delimited fields terminated by ','
select MTA_Pay.*
from MTA_Pay
order by zipcode;
