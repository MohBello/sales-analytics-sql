INSERT INTO customers VALUES
	(1, 'Bob Smith', 'Consumer', 'New York', 'NY', 'USA', 'East'),
    (2, 'Alice Johnson', 'Coporate', 'Los Angeles', 'CA', 'USA', 'West'),
    (3, 'Charlie Lee', 'Home Office', 'Chicago', 'IL', 'USA', 'Centre'),
    (4, 'Diana King', 'Consumer', 'Houston', 'TX', 'USA', 'South');

INSERT INTO products VALUES
	(101, 'Stapler', 'Office Supplies', 'Binders'),
	(102, 'Printer', 'Technology', 'Machines'),
	(103, 'Desk Chair', 'Furniture', 'Chairs'),
	(104, 'Pen Set', 'Office Supplies', 'Art');

INSERT INTO orders VALUES
	(1001, '2023-01-15', 1),
	(1002, '2023-02-10', 2),
	(1003, '2023-02-12', 3),
	(1004, '2023-03-05', 4);

INSERT INTO order_items (order_id, product_id, quantity, price, discount, profit) VALUES
	(1001, 101, 2, 15.00, 0.00, 5.00),
	(1002, 102, 1, 200.00, 20.00, 30.00),
	(1003, 103, 1, 150.00, 10.00, 25.00),
	(1004, 104, 5, 5.00, 0.00, 3.00);

INSERT INTO shipping VALUES
	(1, 1001, 'Second Class', '2023-01-17', 7.00),
	(2, 1002, 'Standard Class', '2023-02-13', 5.50),
	(3, 1003, 'First Class', '2023-02-13', 12.00),
	(4, 1004, 'Standard Class', '2023-03-07', 3.00);

SELECT * FROM orders
JOIN customers USING(customer_id)
JOIN order_items USING(order_id)
JOIN products USING(product_id)
JOIN shipping USING(order_id);
