CREATE DATABASE sales_analytics;
USE sales_analytics;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(200),
    email VARCHAR(200),
    phone VARCHAR(30),
    city VARCHAR(100),
    customer_segment VARCHAR(30),
    created_at DATE,
    cltv DECIMAL(12,2)
);

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(200),
    city VARCHAR(100),
    region VARCHAR(50)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(300),
    category VARCHAR(100),
    price DECIMAL(10,2),
    discount_pct INT,
    avg_rating DECIMAL(3,1),
    stock_qty INT
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    store_id INT,
    order_date DATE,
    sale_event VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_pct INT,
    final_amount DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);





