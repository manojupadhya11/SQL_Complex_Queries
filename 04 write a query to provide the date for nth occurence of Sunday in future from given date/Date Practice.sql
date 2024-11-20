
datepart, datediff, dateadd

select datepart(DAYOFYEAR, '2024-11-20')

select datepart(day, '2024-11-20')

select datepart(WEEK, '2024-11-20')




select dateadd(day,2,'2024-11-20')

select dateadd(MONTH,2,'2024-11-20')

select dateadd(week,2,'2024-11-20')


select DATEDIFF(week, '2024-11-01','2024-12-11')

select DATEDIFF(MONTH, '2024-11-01','2024-12-11')

select DATEDIFF(day, '2024-11-01','2024-12-11')

Use Practice_SQL;

Select * from customer_orders

Select * ,
DATEDIFF(year,dob,getdate()) as customer_age
from customer_orders