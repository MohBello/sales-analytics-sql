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
```sql
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(...) AS total_sales
💡 Insight: Shows business growth over time. Can highlight seasonal patterns.

### 🔹 Top 3 Customers per Month
```sql
RANK() OVER (PARTITION BY month ORDER BY revenue DESC)
💡 Insight: Helps target loyal customers for retention campaigns.

### 🔹 High-Margin Products
WITH ... profit_margin > 0.2 (20%)
💡 Insight: Supports promotion and pricing decisions. Helps identify promotable products for better profitability.

