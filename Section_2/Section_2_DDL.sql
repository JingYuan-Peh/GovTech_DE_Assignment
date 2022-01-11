-- create database carshop
create database carshop;

-- create tables
create table car(
	serialnumber varchar(100) PRIMARY KEY,
	manufacturer varchar(100),
	modelName varchar(100),
	weight numeric,
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
	PRIMARY KEY (serialnumber, salespersonid, customerid, datetime_transacted)
);

-- insert some dummy data
insert into car(serialnumber, manufacturer, modelName, weight, price)
values
('10000', 'Honda', 'Fit', 1000, 50000),
('10001', 'Honda', 'Jazz', 1000, 55000),
('10002', 'Honda', 'Civic', 1000, 70000),
('20000', 'Mercedes Benz', 'CLA180', 1000, 120000),
('20001', 'Mercedes Benz', 'C-Class', 1000, 150000),
('20002', 'Mercedes Benz', 'E-Class', 1000, 250000),
('30000', 'Toyota', 'Yaris', 1000, 50000),
('30001', 'Toyota', 'Corolla Altis', 1000, 55000),
('30002', 'Toyota', 'Camry', 1000, 70000),
('40000', 'BMW', '2 Series', 1000, 80000),
('40001', 'BMW', '3 Series', 1000, 140000),
('40002', 'BMW', '4 Series', 1000, 80000),
('50000', 'Audi', 'A3', 1000, 80000),
('50001', 'Audi', 'A4', 1000, 130000),
('50002', 'Audi', 'A5', 1000, 170000)
;

insert into salesperson(salespersonid,salespersonname)
values
('A100', 'John'),
('A200', 'Jack'),
('A300', 'Jill')
;

insert into customer(customerid,customername,customerphone)
values
('C100', 'John', '91000000'),
('C200', 'Jack', '91000001'),
('C300', 'Jill', '91000002'),
('C400', 'Tom', '91000003'),
('C500', 'Dick', '91000004'),
('C600', 'Harry', '91000005'),
('C700', 'Cass', '91000006'),
('C800', 'Clara', '91000007'),
('C900', 'Candy', '91000008')
;

insert into transaction(serialnumber, salespersonid, customerid, datetime_transacted)
values
('10000', 'A100', 'C100', '2021-11-30 09:00:00'),
('10000', 'A100', 'C200', '2021-11-30 09:00:00'),
('20000', 'A200', 'C300', '2021-11-30 09:00:00'),
('40000', 'A200', 'C300', '2021-11-30 09:00:00'),
('20000', 'A200', 'C400', '2021-11-30 09:00:00'),
('30000', 'A200', 'C200', '2021-11-30 09:00:00'),
('40002', 'A200', 'C300', '2021-11-30 09:00:00'),
('20000', 'A300', 'C200', '2021-12-30 09:00:00'),
('20001', 'A300', 'C700', '2021-12-30 09:00:00'),
('20001', 'A300', 'C600', '2021-12-30 09:00:00'),
('20002', 'A300', 'C800', '2021-12-30 09:00:00'),
('30000', 'A100', 'C800', '2021-12-30 09:00:00'),
('30000', 'A200', 'C500', '2021-12-30 09:00:00'),
('30001', 'A300', 'C400', '2021-12-30 09:00:00'),
('30002', 'A300', 'C300', '2021-12-30 09:00:00'),
('50000', 'A100', 'C200', '2021-12-30 09:00:00'),
('10000', 'A200', 'C100', '2021-12-30 09:00:00'),
('20001', 'A300', 'C300', '2021-12-30 09:00:00'),
('30002', 'A300', 'C500', '2021-12-30 09:00:00'),
('20000', 'A100', 'C100', '2022-01-30 09:00:00'),
('30000', 'A100', 'C200', '2022-01-30 09:00:00'),
('40002', 'A100', 'C300', '2022-01-30 09:00:00'),
('10002', 'A100', 'C400', '2022-01-30 09:00:00'),
('10002', 'A100', 'C500', '2022-01-30 09:00:00'),
('10001', 'A100', 'C600', '2022-01-30 09:00:00'),
('10001', 'A100', 'C700', '2022-01-30 09:00:00'),
('50000', 'A100', 'C800', '2022-01-30 09:00:00')
;