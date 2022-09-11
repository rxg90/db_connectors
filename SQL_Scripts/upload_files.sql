use rocio
--Ingest files:

--nyc_airlines

--create schema stg;
--Create table structure
drop table if exists stg.nyc_airlines;
create table stg.nyc_airlines
(carrier varchar(max) not null
,name varchar(max) not null
)

 
--Import data from table
BULK INSERT stg.nyc_airlines
FROM 'C:\Users\ASUS-PC\Documents\GitRocio\db_connectors\data\nyc_airlines.csv'
WITH 														
(	FIRSTROW = 2
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR='\n'
)


-- nyc_airports
drop table if exists stg.nyc_airport;
create table stg.nyc_airport
(
faa varchar(max) 
,name varchar(max) 
,latitude varchar(max)
,longitude varchar(max)
,altitude varchar(max)
,timezone varchar(max)
,dst varchar(max)
,timezone_name varchar(max)
)

BULK INSERT stg.nyc_airport
FROM 'C:\Users\ASUS-PC\Documents\GitRocio\db_connectors\data\nyc_airports.csv'
WITH 														
(	FIRSTROW = 2
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR='\n'
)
select * from stg.nyc_airport

--nyc_flights
drop table if exists stg.nyc_flights;
create table stg.nyc_flights
(
id varchar(max)
,year varchar(max)
,month varchar(max)
,day varchar(max)
,actual_dep_time varchar(max)
,sched_dep_time varchar(max)
,dep_delay varchar(max)
,actual_arr_time varchar(max)
,sched_arr_time varchar(max)
,arr_delay varchar(max)
,carrier varchar(max)
,flight varchar(max)
,tailnum varchar(max)
,origin varchar(max)
,dest varchar(max)
,air_time varchar(max)
,distance varchar(max)
,hour varchar(max)
,minute varchar(max)
,time_hour varchar(max)
)


BULK INSERT stg.nyc_airport
FROM 'C:\Users\ASUS-PC\Documents\GitRocio\db_connectors\data\nyc_flights.csv'
WITH 														
(	FIRSTROW = 2
    ,FIELDTERMINATOR = ','
    ,ROWTERMINATOR='\n'
)
