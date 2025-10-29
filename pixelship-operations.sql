/*
--------------------------------------------------------------------------------
Ad-hoc Questions 
--------------------------------------------------------------------------------
*/

-- 1: What are the earliest and latest order dates in the orders table?
SELECT MIN(purchase_ts), 
  MAX(purchase_ts)
FROM core.orders;

-- 2: What is the Average Order Value (AOV) for USD purchases in 2019?
SELECT AVG(usd_price)
FROM core.orders
WHERE currency = 'USD'
AND EXTRACT(YEAR FROM purchase_ts) = 2019;
--and purchase_ts between '2019-01-01' and '2019-12-31'
--and purchase_ts >= '2019-01-01' and purchase_ts <= '2019-12-31'

-- 3: Find all customers (id, loyalty status, creation date) who created their accounts on 'desktop' or 'mobile'.
SELECT id AS customer_id, 
  loyalty_program AS is_loyalty_program,
  created_on AS account_creation_date
FROM core.customers
WHERE account_creation_method IN ('desktop','mobile');
--where account_creation_method = 'desktop' or account_creation_method = 'mobile'

-- 4: What are the distinct product names sold in 'AUD' on the 'website' platform, ordered alphabetically?
SELECT DISTINCT product_name
FROM core.orders
WHERE currency = 'AUD'
AND purchase_platform = 'website'
ORDER BY 1;

-- 5: Show 10 sample rows from the geo_lookup table for the 'NA' (North America) region, ordered descending by country.
SELECT *
FROM core.geo_lookup
WHERE region = 'NA'
ORDER BY 1 DESC
LIMIT 10;

-- 6: How many distinct orders were shipped each month, ordered by most recent month first?
SELECT DATE_TRUNC(ship_ts, MONTH) AS month,
  COUNT(DISTINCT order_id) AS order_count
FROM core.order_status
GROUP BY 1
ORDER BY 1 DESC;

-- 7: What was the AOV for each year, ordered by year?
SELECT EXTRACT(YEAR FROM purchase_ts) AS year, 
  ROUND(AVG(usd_price),2) AS aov
FROM core.orders
GROUP BY 1
ORDER BY 1;

-- 8: Add a new column 'is_refund' (1 for refunded, 0 for not) to the order_status table. Show 20 rows.
SELECT *, 
  CASE WHEN refund_ts IS NOT NULL THEN 1 ELSE 0 END AS is_refund
FROM core.order_status
LIMIT 20;

-- 9: What are the distinct product IDs and names for all 'Apple' products and 'Macbook Air Laptop'?
SELECT DISTINCT product_id,
  product_name
FROM core.orders
WHERE product_name LIKE '%Apple%'
OR product_name = 'Macbook Air Laptop';
--where product_name in ('Apple Airpods Headphones','Apple iPhone','Macbook Air Laptop')

-- 10: Calculate the 'days_to_ship' (time from purchase to shipment) for all orders.
SELECT *, 
  DATE_DIFF(ship_ts,purchase_ts, DAY) AS days_to_ship
FROM core.order_status;

/*
--------------------------------------------------------------------------------
Follow-up Business Questions 
--------------------------------------------------------------------------------
*/

-- 1: What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years?
	-- Join orders to customers then customers to geolookup, filter to macbooks in NA, group by quarters, 
	-- order by years asc, select count of order id, sum of usd price, and average of usd price

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

-- 2: What is the average quarterly order count and total sales for Macbooks sold in North America?

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

-- 3: For products purchased in 2022 on the website or products purchased on mobile in any year, which region has the average highest time to deliver?
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

-- 4: Rewrite this query for website purchases made in 2022 or Samsung purchases made in 2021, expressing time to deliver in weeks instead of days.

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

-- 5: What was the refund rate and refund count for each product overall?
	-- join orders to order_status on order id, clean product name '27in', create helper column for refunds, sum refunds, 
	-- avg refunds, group by product name, order by refund rate

SELECT CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE product_name END as product_clean,
  SUM(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as is_refund,
  AVG(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as refund_rate
FROM core.orders
JOIN core.order_status as status
  ON orders.id = status.order_id
GROUP BY 1
ORDER BY 3;

-- 6: What was the refund rate and refund count for each product per year?

SELECT extract(year from orders.purchase_ts) as purchase_year,
  CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE product_name END AS product_clean,
  SUM(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as is_refund,
  AVG(CASE WHEN refund_ts IS NULL THEN 0 ELSE 1 END) as refund_rate
FROM core.orders
JOIN core.order_status as status
  ON orders.id = status.order_id
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 7: Within each region, what is the most popular product?
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

-- 8: How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers?
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

-- 9: Update this query to split the time to purchase per loyalty program, per purchase platform. 
  -- Return the number of records to benchmark the severity of nulls.

SELECT loyalty_program,
  purchase_platform,
  ROUND(AVG(DATE_DIFF(purchase_ts, customers.created_on, day)),2) as avg_days_to_purchase,
  ROUND(AVG(DATE_DIFF(purchase_ts, customers.created_on, month)),2) as avg_month_to_purchase,
  COUNT(*) as order_count
FROM core.orders
JOIN core.customers
  ON orders.customer_id = customers.id
GROUP BY 1, 2;
