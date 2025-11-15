# Retail-Sales-Analytics-SQL-Project

# Objective 
This project is an end-to-end **SQL data analytics case study** that simulates a real-world retail environment.  
The goal is to explore, analyze, and derive actionable business insights from a structured database that includes customers, orders, stores, products, and order items.

The analysis answers practical business questions around:
- Revenue performance
- Product trends
- Customer behavior
- Discount effectiveness
- Store and regional sales distribution


---

## Analysis Queries Included
All queries are available in **[`Analysis_queries.sql`]**.  
Below is a summary of what each query reveals.

---

## 1. Business Overview
**Query:** *Total Revenue, Orders, and Customers*  
 Measures company-wide performance by counting unique customers and orders, and computing total revenue.

**Query:** *Average Order Value (AOV)*  
 Calculates how much revenue is generated per order on average — a key profitability metric.

---

## 2. Store and Regional Performance
**Query:** *Revenue by Store*  
 Identifies top-performing stores based on total revenue.

**Query:** *Revenue Contribution by Region*  
 Shows which regions (North, South, East, West) drive the highest percentage of total revenue.

**Query:** *Sales by City*  
 Determines the cities contributing most to overall sales.

---

## 3. Product and Category Analysis
**Query:** *Top 10 Products by Revenue*  
 Lists the best-selling products by total revenue and quantity sold.

**Query:** *Most Popular Product Categories*  
 Highlights categories with the highest sales volume.

**Query:** *Product Profitability by Discount Range*  
 Groups products into discount tiers (No, Low, Medium, High) to assess sales vs. discount impact.

---

## 4. Customer Insights
**Query:** *Top Customers by Total Spend*  
 Finds the highest-spending customers, along with their total orders and city.

**Query:** *Repeat Customers (Retention)*  
 Identifies customers who made multiple purchases — an indicator of loyalty.

---

## 5. Discounts and Sale Events
**Query:** *Revenue by Sale Event*  
 Measures revenue generated during marketing events like “New Year Sale” or “Diwali Offer.”

**Query:** *Discount Impact Analysis*  
 Compares total sales before vs. after discounts to evaluate how much revenue is affected by pricing strategies.

---

## 6. Trend Analysis
**Query:** *Monthly Revenue Trend*  
 Tracks total sales month by month to identify growth patterns and seasonal peaks.

---

## 💡 Example Query
```sql
-- Top 10 Products by Revenue
SELECT 
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_qty_sold,
    ROUND(SUM(oi.final_amount), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;


