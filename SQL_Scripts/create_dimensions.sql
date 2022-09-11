--Create dimensions:

--Airline

--select * from stg.nyc_airlines
drop table if exists dbo.dim_airline;
create table dbo.dim_airline
(airline_id INT IDENTITY(1,1) NOT NULL
,carrier_id varchar(2) PRIMARY KEY not null
,carrier_name varchar(100)
)

insert into dbo.dim_airline
select	distinct
		cast(ltrim(rtrim(carrier)) as varchar(2)) 
		,cast(ltrim(rtrim(name)) as varchar(100))
from stg.nyc_airlines

--select * from dbo.dim_airline

--Airport:

drop table if exists dbo.dim_airport;
create table dbo.dim_airport
(
airport_id INT IDENTITY(1,1) NOT NULL
,faa varchar(3) PRIMARY KEY not null
,airport_name varchar(150) 
,latitude float
,longitude float
,altitude float
,timezone real
,dst varchar(1)
,timezone_name varchar(150)
)

insert into dbo.dim_airport
select distinct cast(rtrim(ltrim(faa)) as varchar(3))
,cast(rtrim(ltrim(name)) as varchar(150))
,cast(rtrim(ltrim(latitude)) as float)
,cast(rtrim(ltrim(longitude)) as float)
,cast(rtrim(ltrim(altitude)) as float)
,cast(rtrim(ltrim(timezone)) as real)
,cast(rtrim(ltrim(dst)) as varchar(1))
,cast(rtrim(ltrim(timezone_name)) as varchar(150))
from stg.nyc_airport

select * from dbo.dim_airport


--Planes:
--select * from stg.nyc_planes 
drop table if exists dbo.dim_plane;
create table dbo.dim_plane
(
plane_id int IDENTITY(1,1) not null
,tailnum varchar(6) PRIMARY KEY not null
,year int 
,plane_type varchar(100) 
,manufacturer varchar(50) 
,model varchar(50) 
,engines int
,seats int
,speed int
,engine varchar(50) 
)


insert into dbo.dim_plane
select distinct 
cast(rtrim(ltrim(tailnum)) as varchar(6))
,case when [year]='NA' then null else cast([year] as int) end [year]
,cast(rtrim(ltrim(type)) as varchar(100))
,cast(rtrim(ltrim(manufacturer)) as varchar(50))
,cast(rtrim(ltrim(model)) as varchar(50))
,case when [engines]='NA' then null else cast([engines] as int) end engines
,case when [seats]='NA' then null else cast([seats] as int) end seats
,case when [speed]='NA' then null else cast([speed] as int) end seats
,cast(rtrim(ltrim(engine)) as varchar(50))
from stg.nyc_planes


--select top 2 * from dbo.dim_plane
/*
select top 2 * from stg.nyc_flights

select flight,tailnum,time_hour,count(*)
from stg.nyc_flights
group by flight,tailnum,time_hour
having count(*) >1

select * from stg.nyc_flights
where flight = '11'
and time_hour='2013-01-01T12:00:00Z'
*/
drop table if exists dbo.fact_flights;
create table dbo.fact_flights
(
flight_id int
,recorddate datetime not null--,time_hour 
--,year int
--,month int
--,day int
,actual_dep_time int
,sched_dep_time int
,dep_delay int
,actual_arr_time int
,sched_arr_time int
,arr_delay int
,airline_id int
,flight int not null
,plane_id int not null
,origin_airport_id int
,dest_airport_id int
,air_time int
,distance int
--,hour int
--,minute int
--,rec_hash binary
--,key_hash binary
)

--drop and recreate table 
insert into dbo.fact_flights
select 
cast(f.id as int)
,cast(time_hour as datetime)
--,cast(f.year as int)
--,cast(month as int)
--,cast(day as int)
,cast(actual_dep_time as int)
,cast(sched_dep_time as int)
,cast(dep_delay as int)
,cast(actual_arr_time as int)
,cast(sched_arr_time as int)
,cast(arr_delay as int)
,a.airline_id
,cast(flight as int )
,plane_id
,a1.airport_id
,a2.airport_id
,cast(air_time as int)
,cast(distance as int)
--,cast(hour as int)
--,cast(minute as int)
--,cast(rec_hash binary
--,cast(key_hash binary
from stg.nyc_flights f
inner join dbo.dim_airline a
on f.carrier = a.carrier_id
inner join dbo.dim_plane p
on f.tailnum = p.tailnum
inner join dbo.dim_airport a1
on f.origin = a1.faa
inner join dbo.dim_airport a2
on f.dest = a2.faa
