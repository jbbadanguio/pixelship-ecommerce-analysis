/*
PIXELSHIP - SUPPLY CHAIN AND PROFITIBILITY ANALYSIS
*/

-- Query 1: How did our fulfillment performance change over time?
	-- This query calculates our core KPIs for each month from 2019-2022.
	-- Using monthly data gives us a more granular view than annual.

select extract(year from purchase_ts) as purchase_year,
  extract(month from purchase_ts) as month_year,
  round(avg(date_diff(ship_ts, purchase_ts, day)), 2) as avg_processing_time,
  round(avg(date_diff(delivery_ts, purchase_ts, day)), 2) as avg_total_fulfillment_time,
from core.order_status
where ship_ts is not null
  and delivery_Ts is not null
group by 1, 2
order by 1, 2;

-- Query 2: What is the financial impact of these delays?
	-- This query quantifies the financial impact of delays.
	-- Calculate fulfillment time for each order with CTE.
	-- Group those orders into buckets to calculate the refund rate for each.

with fulfillment_details as (
  select order_id,
    date_diff(delivery_ts, purchase_Ts, day) as total_fulfillment_days,
    case when refund_ts is not null then 1 else 0 end as is_Refunded
  from core.order_status
  where delivery_ts is not null
)

select
  case
    when total_fulfillment_days <= 7 then '1. 0-7 Days'
    when total_fulfillment_days <= 14 then '2. 8-14 Days'
    when total_fulfillment_days <= 21 then '3. 15-21 Days' 
    else '4. 22+ Days'
  end as fulfillment_bucket,
  count(order_id) as total_orders,
    round(avg(is_refunded) * 100, 2) as refund_rate
from fulfillment_details
group by 1
order by 1;


-- Query 3: Which specific orders should we investigate?
	-- This query provides Head of Ops an actionable list of outlier orders.
	-- Calculate the monthly average delivery time for each country with a window function.
	-- Calculate variance from average to show how much worse an order was than the average.
	-- Filter to delays being 10+ days longer than the monthly average

with monthly_country_performance as (
    select
        order_id,
        country_code,
        status.purchase_ts,
        date_diff(status.delivery_ts, status.purchase_ts, day) as total_fulfillment_days,
        avg(date_diff(status.delivery_ts, status.purchase_ts, day)) over (partition by country_code, extract(year from status.purchase_ts), 
        extract(month from status.purchase_ts)) as monthly_avg_fulfillment
    from core.order_status status
left join core.orders
  on status.order_id = orders.id
left join core.customers
  on orders.customer_id = customers.id
left join core.geo_lookup geo
	on geo.country = customers.country_code
    where delivery_ts is not null
)

select
    order_id,
    country_code,
	region,
    purchase_ts,
    total_fulfillment_days,
    round(monthly_avg_fulfillment, 1) as monthly_avg_fulfillment,
    round(total_fulfillment_days - monthly_avg_fulfillment, 1) as variance_from_average
from monthly_country_performance
where (total_fulfillment_days - monthly_avg_fulfillment) > 10
order by variance_from_average desc;
