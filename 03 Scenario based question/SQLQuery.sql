Use Practice_SQL;

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('Manu','Bangalore','Manu@gmail.com',1,'CPU'),
('Manu','Bangalore','Manu1@gmail.com',1,'CPU'),
('Manu','Bangalore','Manu2@gmail.com',2,'DESKTOP')
,('Saanvi','Bangalore','Saanvi@gmail.com',2,'DESKTOP'),
('Saanvi','Bangalore','Saanvi1@gmail.com',2,'DESKTOP'),
('Saanvi','Bangalore','Saanvi2@gmail.com',1,'MONITOR')

Select * from entries; 

with 
distinct_resorces as (select distinct name, resources from entries),
agg_resources as (select name, STRING_AGG(resources, ',') as used_resources from distinct_resorces group by name),
total_visits as (select name, count(1) as total_visits, STRING_AGG(resources, ',') as resources_used from entries
group by name),
floor_visit as 
(select name, floor, count(1) as no_of_floor_visit,
rank() over(partition by name order by count(1) desc) as ran
from entries
group by name, floor)
select fv.name, fv.floor as most_visited_floor, tv.total_visits, tv.resources_used
from floor_visit as fv 
inner join total_visits tv on fv.name  = tv.name
inner join agg_resources ar on fv.name = ar.name
where ran = 1


with floor_visit as (
select name, floor, count(1) as total_no_visits,
rank() over(partition by name order by count(1)) as ran 
from entries
group by floor, name)
select fv.name, fv.floor as most_visited
from floor_visit as fv
where ran = 1