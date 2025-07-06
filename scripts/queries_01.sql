-- =================================================================
-- SALES ANALYTICS DASHBOARD: ANALYSIS QUERIES
-- Description: Business-focused SQL insights for sales performance
-- =================================================================

-- 1. Total sales and profit per month
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity * price - discount) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
JOIN order_items USING(order_id)
GROUP BY month
ORDER BY month;

-- 💡 Insight: Shows business growth over time. Can highlight seasonal patterns.

------------------------------------------------------

-- 2. Best-selling products by revenue
SELECT 
    product_name,
    SUM(quantity * price - discount) AS revenue
FROM order_items
JOIN products USING(product_id)
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

-- 💡 Insight: Helps identify high-performing products for inventory and marketing focus.

------------------------------------------------------

-- 3. Top customer by total revenue
SELECT 
    customer_name,
    SUM(quantity * price - discount) AS total_spent
FROM orders
JOIN customers USING(customer_id)
JOIN order_items USING(order_id)
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- 💡 Insight: Understand who your most valuable client is.

------------------------------------------------------

-- 4. Total sales by region
SELECT 
    region,
    SUM(quantity * price - discount) AS total_sales
FROM customers
JOIN orders USING(customer_id)
JOIN order_items USING(order_id)
GROUP BY region
ORDER BY total_sales DESC;

-- 💡 Insight: Supports decision-making for regional investments or marketing.

------------------------------------------------------

-- 5. Most profitable product category
SELECT 
    category,
    SUM(profit) AS total_profit
FROM products
JOIN order_items USING(product_id)
GROUP BY category
ORDER BY total_profit DESC;

-- 💡 Insight: Profit may not match sales volume. Focus on what makes the most money.

