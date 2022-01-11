-- create database carshop
create database carshop;

-- create tables
create table car(
	serialnumber varchar(100) PRIMARY KEY,
	manufacturer varchar(100),
	modelName varchar(100),
	weight varchar(100),
	price numeric
);

create table salesperson(
	salespersonid varchar(100) PRIMARY KEY,
	salespersonname varchar(100)
);

create table customer(
	customerid varchar(100) PRIMARY KEY,
	customername varchar(100),
	customerphone varchar(100)
);

create table transaction(
	serialnumber varchar(100) REFERENCES car,
	salespersonid varchar(100) REFERENCES salesperson,
	customerid varchar(100) REFERENCES customer,
	datetime_transacted TIMESTAMP,
	PRIMARY KEY (serialnumber, salespersonid, customerid)
);

-- I want to know the list of our customers and their spending.
select
	c.customerid, sum(ca.price) as total_spending
from
	customer c left join transaction t on c.customerid = t.customerid
	left join car ca on t.serialnumber = ca.serialnumber
group by c.customerid;

-- I want to find out the top 3 car manufacturers that customers bought by sales (quantity)
-- and the sales number for it in the current month.
with
	manu_total_cars as (
		select
			ca.manufacturer, count(t.serialnumber) as total_cars
		from
			transaction t left join car ca on t.serialnumber = ca.serialnumber
		group by ca.manufacturer
	),
	top_3_manu as (
		select
			manufacturer, total_cars,
			dense_rank() over (order by total_cars) as rnk
		from
			manu_total_cars
	)
select
	temp.manufacturer, total_cars
from
	top_3_manu temp
where
	temp.rnk <= 3
;