# 📊 Sales Analytics Dashboard (SQL Project)

This project demonstrates how I used **MySQL Workbench** to build a real-world **Sales Analytics backend** using pure **SQL**. It covers schema design, data modeling, business-focused queries, and reusable views — everything needed to support a sales reporting system or power a future dashboard. 
The goal was to extract actionable insights from sales data using SQL alone, without relying on visualization tools.

---

## 🚀 Project Highlights

- ✅ Designed and queried a sales database
- 📈 Analyzed revenue, profit, customer behavior, and product performance
- 📦 Used window functions, CTEs, and views for advanced analysis
- 🔎 Optimized SQL queries for clarity and business value

---

## 🧱 Tech Stack

- **SQL**: MySQL 8+
- **Tools**: MySQL Workbench

---

## 📂 Project Structure

| File | Description |
|------|-------------|
| `01_create_tables.sql` | Table schema creation |
| `02_insert_data.sql`   | Sample/mock data inserts |
| `03_analysis_queries.sql` | Basic business queries |
| `04_advanced_queries.sql` | CTEs, window functions, and complex logic |
| `05_views.sql`         | Reusable views for dashboards |

---

## 📊 Sample Queries & Insights

### 🔹 Total Sales by Month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(...) AS total_sales

```sql
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity * price - discount) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
JOIN order_items USING(order_id)
GROUP BY month
ORDER BY month;
```

💡 Insight: Shows business growth over time. Can highlight seasonal patterns.


### 🔹 Top 3 Customers per Month
RANK() OVER (PARTITION BY month ORDER BY revenue DESC)

```sql
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
```

💡 Insight: Helps target loyal customers for retention campaigns.

### 🔹 High-Margin Products
WITH ... profit_margin > 0.2 (20%)

```sql
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
```

💡 Insight: Supports promotion and pricing decisions. Helps identify promotable products for better profitability.

