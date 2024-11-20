Use Practice_SQL;

create table icc_worldcup(
Team_1 varchar(60),
Team_2 varchar(60),
Winner varchar(60));

Insert into icc_worldcup values('India','SriLanka','India');
Insert into icc_worldcup values('SriLanka','Australia','Australia');
Insert into icc_worldcup values('SouthAfrica','England','England');
Insert into icc_worldcup values('Australia','India','India');
Insert into icc_worldcup values('England','NewZeland','NewZeland');

Select * from icc_worldcup;


select team_name, count(1) as num_matches, sum(win_flag) as no_of_matches_won, count(1) - sum(win_flag) as no_of_losses
from(
select Team_1 as team_name, case when Team_1 = winner then 1 else 0 end as win_flag
from icc_worldcup
Union all
select Team_2 as team_name, case when Team_2 = winner then 1 else 0 end as win_flag
from icc_worldcup) A
group by team_name
order  by no_of_matches_won desc