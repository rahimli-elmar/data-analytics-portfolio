/* Project 1: Sales Analysis (SQL)
   Author: Elmar Rahimli
*/

/* ===== Setup: Create table + sample inserts ===== */

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE sales';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN RAISE; END IF; -- ignore "table does not exist"
END;
/

CREATE TABLE sales (
  order_id        NUMBER,
  order_date      DATE,
  customer_name   VARCHAR2(50),
  product_name    VARCHAR2(50),
  category        VARCHAR2(30),
  quantity        NUMBER,
  unit_price      NUMBER(10,2),
  city            VARCHAR2(30)
);

INSERT INTO sales VALUES (1001, DATE '2025-10-05', 'Ali Mammadov',      'Pizza Margherita', 'Pizza',  2,  8, 'Baku');
INSERT INTO sales VALUES (1002, DATE '2025-10-05', 'Nigar Aliyeva',     'Sushi Set',        'Sushi',  1, 15, 'Baku');
INSERT INTO sales VALUES (1003, DATE '2025-11-12', 'Rashad Hasanov',    'Burger Classic',   'Burger', 3,  6, 'Sumqayit');
INSERT INTO sales VALUES (1004, DATE '2025-11-12', 'Sevda Karimova',    'Pizza Pepperoni',  'Pizza',  1,  9, 'Baku');
INSERT INTO sales VALUES (1005, DATE '2025-12-01', 'Kamran Suleymanli', 'Sushi Set',        'Sushi',  2, 15, 'Ganja');
INSERT INTO sales VALUES (1006, DATE '2025-12-15', 'Aysel Huseynova',   'Pasta Alfredo',    'Pasta',  1, 10, 'Baku');
INSERT INTO sales VALUES (1007, DATE '2026-01-08', 'Ali Mammadov',      'Burger Classic',   'Burger', 2,  6, 'Baku');
INSERT INTO sales VALUES (1008, DATE '2026-01-08', 'Nigar Aliyeva',     'Pizza Margherita', 'Pizza',  1,  8, 'Sumqayit');
INSERT INTO sales VALUES (1009, DATE '2026-02-02', 'Rashad Hasanov',    'Sushi Set',        'Sushi',  1, 15, 'Baku');
INSERT INTO sales VALUES (1010, DATE '2026-02-02', 'Sevda Karimova',    'Pasta Alfredo',    'Pasta',  2, 10, 'Ganja');

COMMIT;



-- 1) Total revenue
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM sales;

-- 2) Monthly revenue trend
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(quantity * unit_price) AS monthly_revenue
FROM sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 3) Top 10 best-selling products
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
