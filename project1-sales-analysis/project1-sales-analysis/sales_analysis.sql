/* Project 1: Sales Analysis (SQL)
   Author: Elmar Rahimli
   Notes: Replace table/column names if your schema differs.
*/

-- 1) Total revenue
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM sales;

-- 2) Monthly revenue trend
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(quantity * unit_price)     AS monthly_revenue
FROM sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 3) Top 10 best-selling products by quantity
SELECT
    product_name,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC
FETCH FIRST 10 ROWS ONLY;

-- 4) Top 10 customers by revenue
SELECT
    customer_name,
    SUM(quantity * unit_price) AS customer_revenue
FROM sales
GROUP BY customer_name
ORDER BY customer_revenue DESC
FETCH FIRST 10 ROWS ONLY;
