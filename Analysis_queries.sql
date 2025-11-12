
-- Total Revenue, Orders, and Customers
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(oi.final_amount), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id;


-- Revenue by Store
SELECT 
    s.store_name,
    ROUND(SUM(oi.final_amount), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;


-- Sales by City
SELECT 
    c.city,
    ROUND(SUM(oi.final_amount), 2) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_sales DESC;

-- Average Order Value (AOV)
SELECT 
    ROUND(SUM(final_amount) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM order_items;

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

-- Most Popular Product Categories

SELECT 
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.final_amount), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_units_sold DESC;

-- Top Customers by Total Spend

SELECT 
    c.full_name,
    c.city,
    ROUND(SUM(oi.final_amount), 2) AS total_spent,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name, c.city
ORDER BY total_spent DESC
LIMIT 10;

-- Revenue by Sale Event

SELECT 
    o.sale_event,
    ROUND(SUM(oi.final_amount), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.sale_event
ORDER BY total_revenue DESC;

-- Discount Impact Analysis

SELECT 
    ROUND(SUM(oi.unit_price * oi.quantity), 2) AS total_before_discount,
    ROUND(SUM(oi.final_amount), 2) AS total_after_discount,
    ROUND(SUM(oi.unit_price * oi.quantity) - SUM(oi.final_amount), 2) AS total_discount_value
FROM order_items oi;

-- Revenue Contribution by Region

SELECT 
    s.region,
    ROUND(SUM(oi.final_amount), 2) AS region_revenue,
    ROUND(SUM(oi.final_amount) / (SELECT SUM(final_amount) FROM order_items) * 100, 2) AS revenue_percentage
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.region
ORDER BY region_revenue DESC;

-- Monthly Revenue Trend 

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.final_amount), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- Repeat Customers (Customer Retention)

SELECT 
    c.full_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING total_orders > 1
ORDER BY total_orders DESC;

-- Product Profitability by Discount Range

SELECT 
    CASE 
        WHEN discount_pct = 0 THEN 'No Discount'
        WHEN discount_pct <= 10 THEN 'Low (0-10%)'
        WHEN discount_pct <= 20 THEN 'Medium (11-20%)'
        ELSE 'High (21%+)'
    END AS discount_range,
    ROUND(SUM(final_amount), 2) AS total_sales
FROM order_items
GROUP BY discount_range
ORDER BY total_sales DESC;
