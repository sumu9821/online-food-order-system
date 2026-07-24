CREATE DATABASE IF NOT EXISTS online_food_order;
USE online_food_order;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(200)
);

-- Restaurants Table
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100),
    location VARCHAR(100)
);

-- Menu Table
CREATE TABLE menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    food_name VARCHAR(100),
    price DECIMAL(10,2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    menu_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert Customers
INSERT INTO customers (customer_name, phone, address) VALUES
('Rahul', '9876543210', 'Delhi'),
('Priya', '9876501234', 'Mumbai'),
('Amit', '9123456789', 'Kolkata');

-- Insert Restaurants
INSERT INTO restaurants (restaurant_name, location) VALUES
('Spice Hub', 'Delhi'),
('Food Point', 'Mumbai'),
('Tasty Bites', 'Kolkata');

-- Insert Menu
INSERT INTO menu (restaurant_id, food_name, price) VALUES
(1, 'Chicken Biryani', 250.00),
(1, 'Veg Fried Rice', 180.00),
(2, 'Pizza', 220.00),
(2, 'Pasta', 350.00),
(3, 'Burger', 150.00),
(3, 'French Fries', 120.00);

-- Insert Orders
INSERT INTO orders (customer_id, menu_id, quantity, order_date) VALUES
(1, 1, 2, '2026-07-21'),
(2, 3, 1, '2026-07-21'),
(3, 5, 3, '2026-07-21');

-- Insert Payments
INSERT INTO payments (order_id, amount, payment_method, payment_status) VALUES
(1, 500.00, 'UPI', 'Paid'),
(2, 220.00, 'Card', 'Paid'),
(3, 450.00, 'Cash', 'Pending');

-- Sample Queries
SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM menu;
SELECT * FROM orders;
SELECT * FROM payments;

SELECT c.customer_name, m.food_name, o.quantity, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN menu m ON o.menu_id = m.menu_id;

SELECT r.restaurant_name, m.food_name, m.price
FROM restaurants r
JOIN menu m ON r.restaurant_id = m.restaurant_id;

CREATE VIEW order_details AS
SELECT c.customer_name, m.food_name, o.quantity, p.amount, p.payment_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN menu m ON o.menu_id = m.menu_id
JOIN payments p ON o.order_id = p.order_id;

CREATE INDEX idx_customer_name
ON customers(customer_name);