Use Practice_SQL;

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

select * from customer_orders;

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),
(2,200,cast('2022-01-01' as date),2500),
(3,300,cast('2022-01-01' as date),2100),
(4,100,cast('2022-01-02' as date),2000),
(5,400,cast('2022-01-02' as date),2200),
(6,500,cast('2022-01-02' as date),2700),
(7,100,cast('2022-01-03' as date),3000),
(8,400,cast('2022-01-03' as date),1000),
(9,600,cast('2022-01-03' as date),3000);



---first Approach---
with first_visit as(
select customer_id, min(order_date) as first_visit_date
from customer_orders
group by customer_id)
, visit_flag as(
select co.*, fv.first_visit_date,
CASE WHEN co.order_date = fv.first_visit_date then 1 else 0 end as first_visit_flag,
CASE WHEN co.order_date != fv.first_visit_date then 1 else 0 end as repeat_visit_flag
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
)
select order_date, sum(first_visit_flag) as no_of_new_customers, sum(repeat_visit_flag) as no_of_repeat_customers
from visit_flag
group by order_date
;



---Optimized Approach---

with first_visit as(
select customer_id, min(order_date) as first_visit_date
from customer_orders
group by customer_id)
select co.order_date,
sum(CASE WHEN co.order_date = fv.first_visit_date then 1 else 0 end)as first_visit_customer,
sum(CASE WHEN co.order_date != fv.first_visit_date then 1 else 0 end) as repeat_visit_customer
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
group by order_date
;


----Order amount by repeat customer and new customer-----

with first_visit as(
select customer_id, min(order_date) as first_visit_date
from customer_orders
group by customer_id)
select co.order_date,
sum(CASE WHEN co.order_date = fv.first_visit_date then 1 else 0 end)as first_visit_customer,
sum(CASE WHEN co.order_date != fv.first_visit_date then 1 else 0 end) as repeat_visit_customer,
sum(CASE WHEN co.order_date = fv.first_visit_date then 1 else 0 end) as first_customer_amount,
sum(CASE WHEN co.order_date != fv.first_visit_date then 1 else 0 end) as repeat_visit_customer
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
group by order_date
;