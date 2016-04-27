use income;
drop table if exists Payment_raw;
drop table if exists Payment;
drop table if exists AvgPayment;
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

insert overwrite local directory '../data/avg_payment'
row format delimited fields terminated by ','
select zipcode, avg_income, avg_cost, tol_job
from AvgPayment 
order by zipcode;
