-- 1. Sales and profit by category

SELECT
    "Category",
    ROUND(SUM("Sales"),2) AS total_sales,
    ROUND(SUM("Profit"),2) AS total_profit
FROM orders
GROUP BY "Category"
ORDER BY total_sales DESC;


-- 2. Profit by sub-category

SELECT
    "Sub-Category",
    ROUND(SUM("Profit"),2) AS total_profit
FROM orders
GROUP BY "Sub-Category"
ORDER BY total_profit DESC;


-- 3. Monthly sales trend

SELECT
    substr("Order Date", -4) || '-' ||
    printf('%02d', CAST(substr("Order Date", 1, instr("Order Date", '/')-1) AS INTEGER))
    AS month,
    ROUND(SUM("Sales"),2) AS total_sales
FROM orders
GROUP BY month
ORDER BY month;


-- 4. Profit by customer segment

SELECT
    "Segment",
    ROUND(SUM("Sales"),2) AS total_sales,
    ROUND(SUM("Profit"),2) AS total_profit
FROM orders
GROUP BY "Segment"
ORDER BY total_sales DESC;


-- 5. Top 10 customers by sales

SELECT
    "Customer Name",
    ROUND(SUM("Sales"),2) AS total_sales
FROM orders
GROUP BY "Customer Name"
ORDER BY total_sales DESC
LIMIT 10;


-- 6. Top selling products

SELECT
    "Product Name",
    ROUND(SUM("Sales"),2) AS total_sales,
    ROUND(SUM("Profit"),2) AS total_profit
FROM orders
GROUP BY "Product Name"
ORDER BY total_sales DESC
LIMIT 10;


-- 7. Products with negative profit

SELECT
    "Product Name",
    ROUND(SUM("Profit"),2) AS total_profit
FROM orders
GROUP BY "Product Name"
HAVING SUM("Profit") < 0
ORDER BY total_profit ASC
LIMIT 10;