CREATE DATABASE sales_analytics;
USE sales_analytics;

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(100)
);

CREATE TABLE products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    ship_mode VARCHAR(50),
    ship_date DATE,
    shipping_cost DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
