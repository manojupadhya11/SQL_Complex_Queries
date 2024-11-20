--Write a Query to provide the date for nth occurence of Sunday in future from given date
--datepart
--sunday-1
--monday-2
--tuesday-3
--friday-6
--saturday-7

declare @today_date date;
declare @n int;
set @today_date = '2022-01-02';  --saturday
set  @n = 3;

select dateadd(week, @n-1,dateadd(day, 8 - DATEPART(weekday, @today_date), @today_date) )