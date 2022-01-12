-- I want to know the list of our customers and their spending.
select
	c.customerid, coalesce(sum(ca.price), 0) as total_spending
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
	),
	current_month_sales as (
		select
			ca.manufacturer, count(t.serialnumber) as total_cars_current_month
		from
			transaction t left join car ca on t.serialnumber = ca.serialnumber
		where extract(month from datetime_transacted) = extract(month from CURRENT_DATE)
			and extract(year from datetime_transacted) = extract(year from CURRENT_DATE)
		group by ca.manufacturer
	)
select
	ttm.manufacturer, total_cars, total_cars_current_month
from
	top_3_manu ttm left join current_month_sales cms on ttm.manufacturer = cms.manufacturer
where
	ttm.rnk <= 3
order by total_cars desc
;