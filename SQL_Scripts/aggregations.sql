select top 2 * from dbo.fact_flights

--get monthly count of flights per origin airport
select airport_name
,month(recorddate)
,count(*)
from dbo.fact_flights f 
inner join dbo.dim_airport a
on f.origin_airport_id= a.airport_id
group by airport_name
		,month(recorddate)
order by airport_name,month(recorddate)

--get total flights per origin airport
select airport_name
,count(*)
from dbo.fact_flights f 
inner join dbo.dim_airport a
on f.origin_airport_id= a.airport_id
group by airport_name
order by airport_name 

--select top 2* from dbo.fact_flights
--Delayed flights per month/airport
with cte_delayed as
( select flight_id
		,recorddate
		,origin_airport_id
		,case when dep_delay > 0 then 1 else 0 end as delay_flg
from dbo.fact_flights
)
select airport_name
,month(recorddate) Month
,count(*)
from cte_delayed f 
inner join dbo.dim_airport a
on f.origin_airport_id= a.airport_id
where delay_flg = 1
group by airport_name,month(recorddate)
order by airport_name,month(recorddate)