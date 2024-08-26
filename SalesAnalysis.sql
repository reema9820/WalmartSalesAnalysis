-- Create the database if it doesn't already exist
CREATE DATABASE walmartSales IF NOT EXISTS;

-- Create the sales table if it doesn't already exist
CREATE TABLE sales IF NOT EXISTS (
    invoice_id VARCHAR(30) PRIMARY KEY NOT NULL,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- View all records in the sales table
SELECT * FROM sales;

-- Add a new column for time of day
SELECT 
    time,
    CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- Disable safe mode for updates, reconnect to MySQL server if necessary
UPDATE sales
SET time_of_day = CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END;

-- Add day_name column
SELECT 
    date, 
    DAYNAME(date) 
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Add month_name column
SELECT 
    date, 
    MONTHNAME(date) 
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- General Queries -----------------------
-- --------------------------------------------------------------------

-- Find the distinct cities in the sales data
SELECT DISTINCT city FROM sales;

-- Identify the city associated with each branch
SELECT DISTINCT city, branch FROM sales;

-- --------------------------------------------------------------------
-- ---------------------------- Products ------------------------------
-- --------------------------------------------------------------------

-- Determine the distinct product lines in the data
SELECT DISTINCT product_line FROM sales;

-- Identify the most sold product line
SELECT 
    product_line,
    SUM(quantity) AS qty
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- Calculate total revenue by month
SELECT 
    month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- Identify the month with the highest COGS
SELECT 
    month_name AS month,
    SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;

-- Determine the product line with the highest revenue
SELECT 
    product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Find the city with the highest revenue
SELECT 
    branch,
    city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- Determine the product line with the highest VAT percentage
SELECT 
    product_line,
    AVG(tax_pct) AS avg_tax_pct
FROM sales
GROUP BY product_line
ORDER BY avg_tax_pct DESC;

-- Add a remark column based on average sales
SELECT 
    AVG(quantity) AS avg_quantity
FROM sales;

SELECT 
    product_line,
    CASE 
        WHEN AVG(quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM sales
GROUP BY product_line;

-- Identify branches that sold more products than the average
SELECT 
    branch, 
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- Determine the most popular product line by gender
SELECT 
    gender,
    product_line,
    COUNT(*) AS total_count
FROM sales
GROUP BY gender, product_line
ORDER BY total_count DESC;

-- Calculate the average rating for each product line
SELECT 
    product_line,
    ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- ---------------------------- Customers -----------------------------
-- --------------------------------------------------------------------

-- Find distinct customer types in the sales data
SELECT DISTINCT customer_type FROM sales;

-- Find distinct payment methods in the sales data
SELECT DISTINCT payment FROM sales;

-- Determine the most common customer type
SELECT 
    customer_type,
    COUNT(*) AS total_count
FROM sales
GROUP BY customer_type
ORDER BY total_count DESC;

-- Identify the customer type that buys the most
SELECT 
    customer_type,
    COUNT(*) AS total_count
FROM sales
GROUP BY customer_type
ORDER BY total_count DESC;

-- Find the most common gender among customers
SELECT 
    gender,
    COUNT(*) AS gender_count
FROM sales
GROUP BY gender
ORDER BY gender_count DESC;

-- Find gender distribution per branch
SELECT 
    gender,
    COUNT(*) AS gender_count
FROM sales
WHERE branch = 'C'
GROUP BY gender
ORDER BY gender_count DESC;

-- Identify the time of day when customers give the most ratings
SELECT 
    time_of_day,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Identify the time of day when customers give the most ratings per branch
SELECT 
    time_of_day,
    AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Determine the day of the week with the best average ratings
SELECT 
    day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Identify the day of the week with the highest sales per branch
SELECT 
    day_name,
    COUNT(*) AS total_sales
FROM sales
WHERE branch = 'C'
GROUP BY day_name
ORDER BY total_sales DESC;

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Find the number of sales made during different times of the day on Sunday
SELECT 
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Identify the customer type that brings the most revenue
SELECT 
    customer_type,
    SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Find the city with the highest average tax percentage
SELECT 
    city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city
ORDER BY avg_tax_pct DESC;

-- Identify the customer type that pays the most in VAT
SELECT 
    customer_type,
    AVG(tax_pct) AS avg_tax_pct
FROM sales
GROUP BY customer_type
ORDER BY avg_tax_pct DESC;
