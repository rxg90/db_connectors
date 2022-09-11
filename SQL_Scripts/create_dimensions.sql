--Create dimensions:

--Airline

--select * from stg.nyc_airlines
drop table if exists dbo.dim_airline;
create table dbo.dim_airline
(ailine_id INT IDENTITY(1,1) NOT NULL
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


--select * from dbo.dim_plane

--select top 10 * from stg.nyc_flights
drop table if exists stg.nyc_flights;
create table stg.nyc_flights
(
flght_id bigint
,year bigint
,month int
,day int
,actual_dep_time bigint
,sched_dep_time bigint
,dep_delay bigint
,actual_arr_time bigint
,sched_arr_time bigint
,arr_delay bigint
,airline_id varchar(max)
,flight int
,tailnum int
,origin varchar(max)
,dest varchar(max)
,air_time varchar(max)
,distance varchar(max)
,hour varchar(max)
,minute varchar(max)
,time_hour varchar(max)
)
