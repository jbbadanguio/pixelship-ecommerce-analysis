/*
PixelShip: Supply Chain & Profitability Analysis

Objective: 
To analyze PixelShip's global order fulfillment performance from 2019-2022, identify the key drivers of shipping delays, and quantify their direct impact on customer refunds and company profitability.
*/


-- Query 1: Monthly Fulfillment Performance Trends
-- How did our fulfillment performance change over time?

-- This query calculates our core KPIs for each month from 2019-2022.
-- Using monthly data (as per best practices) gives us a more granular view than annual.

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
-- Connecting Fulfillment Delays to Refund Rates

-- This query quantifies the financial impact of delays.
-- We use a CTE to make the logic clean: first, calculate fulfillment time for each order,
-- then group those orders into buckets to calculate the refund rate for each.

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
-- Identifying Severely Delayed Orders with Window Functions

-- This query provides Angie's team with an actionable list of outlier orders.
-- We use a window function to calculate the monthly average delivery time for each country.
-- This is powerful because it compares each order to its direct peers (same country, same month)
-- to determine if it was an outlier.

with monthly_country_performance as (
    select
        order_id,
        country_code,
        status.purchase_ts,
        date_diff(status.delivery_ts, status.purchase_ts, day) as total_fulfillment_days,
        -- calculate the average fulfillment time for that specific country and month
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
    purchase_ts,
    total_fulfillment_days,
    round(monthly_avg_fulfillment, 1) as monthly_avg_fulfillment,
    -- the variance shows how much worse this order was than the average
    round(total_fulfillment_days - monthly_avg_fulfillment, 1) as variance_from_average
from monthly_country_performance
-- we define a "severe" delay as being 10+ days longer than the monthly average
where (total_fulfillment_days - monthly_avg_fulfillment) > 10
order by variance_from_average desc;

/*
INITIAL BUSINESS QUESTIONS
*/

-- What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years?
-- join orders to customers then customers to geolookup, filter to macbooks in NA, group by quarters, order by years asc, select count of order id, sum of usd price, and average of usd price
SELECT DATE_TRUNC(purchase_ts, quarter) as qtr, 
  COUNT(DISTINCT orders.id) as order_count,
  ROUND(SUM(usd_price), 2) as total_sales,
  ROUND(AVG(usd_price), 2) as aov
FROM core.orders
LEFT JOIN core.customers
  ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup geo
	ON geo.country = customers.country_code
WHERE lower(product_name) LIKE "%macbook%"
  AND region = "NA"
GROUP BY 1
ORDER BY 1 DESC;

-- What is the average quarterly order count and total sales for Macbooks sold in North America?
WITH qtr_sales AS (SELECT DATE_TRUNC(purchase_ts, quarter) as qtr, 
  COUNT(DISTINCT orders.id) as order_count,
  ROUND(SUM(usd_price), 2) as total_sales,
  ROUND(AVG(usd_price), 2) as aov
FROM core.orders
LEFT JOIN core.customers
  ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup geo
	ON geo.country = customers.country_code
WHERE lower(product_name) LIKE "%macbook%"
  AND region = "NA"
GROUP BY 1
ORDER BY 1 DESC)

SELECT qtr,
  AVG(order_count) as avg_qtr_count,
  AVG(total_sales) as avg_qtr_sales
FROM qtr_sales
GROUP BY 1
ORDER BY 1 DESC;

-- For products purchased in 2022 on the website or products purchased on mobile in any year, which region has the average highest time to deliver?
-- join order to order_status, filter to 2022, select region, calculate avg of delivery - purchase, group by region, order by time to deliver desc
SELECT geo.region,
  AVG(DATE_DIFF(delivery_ts, status.purchase_ts, day)) as avg_time_to_deliver
FROM core.order_status status
JOIN core.orders
  ON status.order_id = orders.id
LEFT JOIN core.customers
  ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup geo
  ON customers.country_code = geo.country
WHERE (extract(year from status.purchase_ts) = 2022
  AND purchase_platform = "website")
  OR purchase_platform = "mobile app"
GROUP BY 1
ORDER BY 2 desc;

-- Rewrite this query for website purchases made in 2022 or Samsung purchases made in 2021, expressing time to deliver in weeks instead of days.
SELECT geo.region,
  AVG(DATE_DIFF(delivery_ts, status.purchase_ts, week)) as avg_time_to_deliver
FROM core.order_status status
JOIN core.orders
  ON status.order_id = orders.id
LEFT JOIN core.customers
  ON orders.customer_id = customers.id
LEFT JOIN core.geo_lookup geo
  ON customers.country_code = geo.country
WHERE (extract(year from status.purchase_ts) = 2022 AND purchase_platform = "website")
  OR (extract(year from status.purchase_ts) = 2021 AND lower(orders.product_name) LIKE "%samsung%")
GROUP BY 1
ORDER BY 2 desc;

-- What was the refund rate and refund count for each product overall?
-- join orders to order_status on order id, clean product name '27in', create helper column for refunds, sum refunds, avg refunds, group by product name, order by refund rate
SELECT CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE product_name END as product_clean,
  SUM(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as is_refund,
  AVG(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as refund_rate
FROM core.orders
JOIN core.order_status as status
  ON orders.id = status.order_id
GROUP BY 1
ORDER BY 3;

-- What was the refund rate and refund count for each product per year?
SELECT extract(year from orders.purchase_ts) as purchase_year,
  CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE product_name END AS product_clean,
  SUM(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as is_refund,
  AVG(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as refund_rate
FROM core.orders
JOIN core.order_status as status
  ON orders.id = status.order_id
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Within each region, what is the most popular product?
-- join orders to order status and to customers, count total orders by product, per region in a CTE
-- rank each product and region by total orders in new CTE
-- order ranking desc
WITH sales_by_product AS (
  SELECT region,
    product_name,
    COUNT(DISTINCT orders.id) as total_orders
  FROM core.orders
  JOIN core.order_status status
    ON status.order_id = orders.id
  LEFT JOIN core.customers
    ON orders.customer_id = customers.id
  LEFT JOIN core.geo_lookup geo
    ON customers.country_code = geo.country
  GROUP BY 1, 2),

ranked_orders AS (
  SELECT *,
    row_number() over (partition by region order by total_orders desc) as order_ranking
  FROM sales_by_product
  ORDER BY 4 ASC) -- 4 = total_orders

SELECT *
FROM ranked_orders 
WHERE order_ranking = 1;

-- How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers?
-- join orders to customers
-- time_to_purchase = purchase_ts - customers.created_on, take average
-- group by loyalty_program
SELECT loyalty_program,
  ROUND(AVG(DATE_DIFF(purchase_ts, customers.created_on, day)),2) as avg_days_to_purchase,
  ROUND(AVG(DATE_DIFF(purchase_ts, customers.created_on, month)),2) as avg_month_to_purchase
FROM core.orders
JOIN core.customers
  ON orders.customer_id = customers.id
GROUP BY 1;

-- Update this query to split the time to purchase per loyalty program, per purchase platform. Return the number of records to benchmark the severity of nulls.
SELECT loyalty_program,
  purchase_platform,
  ROUND(AVG(DATE_DIFF(purchase_ts, customers.created_on, day)),2) as avg_days_to_purchase,
  ROUND(AVG(DATE_DIFF(purchase_ts, customers.created_on, month)),2) as avg_month_to_purchase,
  COUNT(*) as order_count
FROM core.orders
JOIN core.customers
  ON orders.customer_id = customers.id
GROUP BY 1, 2;
