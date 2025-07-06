-- ==========================================
-- SALES ANALYTICS DASHBOARD: ADVANCED QUERIES
-- ==========================================

-- 1. Top 3 Customers by Month
-- ---------------------------
-- This query identifies the top 3 revenue-generating customers each month.
-- It uses the RANK() window function to rank customers within each month 
-- based on their total spend.
-- Business Insight: Supports loyalty programs and retention strategies.

WITH ranked_customers AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        customer_name,
        SUM(quantity * price - discount) AS total_spent,
        RANK() OVER (
            PARTITION BY DATE_FORMAT(order_date, '%Y-%m') 
            ORDER BY SUM(quantity * price - discount) DESC
        ) AS rank_in_month
    FROM orders
    JOIN customers USING(customer_id)
    JOIN order_items USING(order_id)
    GROUP BY month, customer_name
)

SELECT *
FROM ranked_customers
WHERE rank_in_month <= 3
ORDER BY month, rank_in_month;


-- ----------------------------------------------------------

-- 2. Year-over-Year Monthly Sales Growth
-- --------------------------------------
-- This query calculates monthly sales growth by comparing the current year's
-- performance to the previous year using the LAG() function.
-- Business Insight: Reveals seasonal patterns and long-term growth trends.

SELECT 
    DATE_FORMAT(order_date, '%m') AS month_name,
    YEAR(order_date) AS year,
    SUM(quantity * price - discount) AS total_sales,
    LAG(SUM(quantity * price - discount)) OVER (
        PARTITION BY DATE_FORMAT(order_date, '%m') 
        ORDER BY YEAR(order_date)
    ) AS prev_year_sales,
    ROUND((
        SUM(quantity * price - discount) -
        LAG(SUM(quantity * price - discount)) OVER (
            PARTITION BY DATE_FORMAT(order_date, '%m') 
            ORDER BY YEAR(order_date)
        )
    ) / LAG(SUM(quantity * price - discount)) OVER (
            PARTITION BY DATE_FORMAT(order_date, '%m') 
            ORDER BY YEAR(order_date)
    ) * 100, 2) AS yoy_growth_percent
FROM orders
JOIN order_items USING(order_id)
GROUP BY year, month_name
ORDER BY month_name, year;

-- ----------------------------------------------------------

-- 3. CTE: Flag High-Margin Products
-- ---------------------------------
-- This Common Table Expression (CTE) calculates profit margin for each product.
-- Products with margin > 20% are considered high-margin and potential focus items.
-- Business Insight: Supports promotion and pricing decisions.

WITH product_profit_margin AS (
    SELECT 
        product_id,
        product_name,
        SUM(profit) AS total_profit,
        SUM(quantity * price - discount) AS total_revenue,
        ROUND(SUM(profit) / NULLIF(SUM(quantity * price - discount), 0), 2) AS profit_margin
    FROM order_items
    JOIN products USING(product_id)
    GROUP BY product_id, product_name
)
SELECT *
FROM product_profit_margin
WHERE profit_margin > 0.2
ORDER BY profit_margin DESC;

-- ----------------------------------------------------------

-- 4. Segment-wise Revenue and Average Order Value
-- -----------------------------------------------
-- This query compares customer segments by total revenue and AOV (average order value).
-- Business Insight: Helps tailor marketing to specific customer segments based on value.

SELECT 
    segment,
    COUNT(DISTINCT order_id) AS num_orders,
    SUM(quantity * price - discount) AS total_revenue,
    ROUND(SUM(quantity * price - discount) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM customers
JOIN orders USING(customer_id)
JOIN order_items USING(order_id)
GROUP BY segment
ORDER BY total_revenue DESC;

-- ----------------------------------------------------------

-- 5. Create View: Monthly KPIs
-- ----------------------------
-- This view summarizes key monthly metrics: total orders, sales, and profit.
-- Business Insight: View can be used in dashboards and scheduled reports.

-- DROP VIEW IF EXISTS monthly_kpis;

CREATE VIEW monthly_kpis AS
SELECT 
    DATE_FORMAT(orders.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT orders.order_id) AS total_orders,
    SUM(order_items.quantity * order_items.price - order_items.discount) AS total_sales,
    SUM(order_items.profit) AS total_profit
FROM orders
JOIN order_items USING(order_id)
GROUP BY DATE_FORMAT(orders.order_date, '%Y-%m');

-- Example usage:
-- SELECT * FROM monthly_kpis;
SELECT * FROM monthly_kpis WHERE month >= '2023-01';

