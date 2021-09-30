-- inner join
-- customer and order table

SELECT DISTINCT(customer_id) AS customer_id FROM `orders`

SELECT * FROM `customers`

SELECT orders.id AS orderId, CONCAT(customers.first_name, " " ,customers.last_name) AS Name FROM customers INNER JOIN orders ON orders.customer_id = customers.id

-- left join

SELECT orders.id AS orderId, CONCAT(customers.first_name, " " ,customers.last_name) AS Name FROM customers LEFT JOIN orders ON orders.customer_id = customers.id

-- right join
-- employee and order table

SELECT DISTINCT(employee_id) FROM `orders`

SELECT orders.id, CONCAT(employees.first_name," ",employees.last_name) AS Name FROM orders RIGHT JOIN employees ON orders.employee_id = employees.id

-- union

SELECT customers.city FROM customers UNION SELECT suppliers.city FROM suppliers

SELECT customers.city FROM customers UNION ALL SELECT suppliers.city FROM suppliers



UPDATE `suppliers` SET `city` = 'Seattle', `state_province` = 'WA', `country_region` = 'USA' WHERE `suppliers`.`id` = 2;
SELECT 'Customer' AS Type, City FROM customers UNION ALL SELECT 'Supplier', City FROM suppliers


-- group by

SELECT COUNT(customers.id) AS totalCustomers,city FROM customers GROUP BY city

SELECT COUNT(customers.id) AS totalCustomers,city FROM customers GROUP BY city ORDER BY city DESC

SELECT COUNT(employees.id) AS noOfEmployees, city FROM employees GROUP BY city ORDER BY noOfEmployees DESC

SELECT COUNT(employees.id) AS noOfEmployees, city FROM employees GROUP BY city ORDER BY 2 ASC

-- group by with join

SELECT shippers.company,COUNT(orders.shipper_id) AS totalOrders FROM orders RIGHT JOIN shippers ON shippers.id = orders.shipper_id GROUP BY shippers.company

SELECT shippers.company,COUNT(orders.shipper_id) AS totalOrders FROM orders RIGHT JOIN shippers ON shippers.id = orders.shipper_id GROUP BY shippers.company ORDER BY 1 DESC

-- having
-- not possible with where
SELECT COUNT(customers.id), customers.city FROM customers GROUP BY customers.city WHERE COUNT(customers.id) > 1;

SELECT COUNT(customers.id) AS NoOfCustomers, customers.city FROM customers GROUP BY customers.city HAVING NoOfCustomers > 1

SELECT COUNT(customers.id) AS NoOfCustomers, customers.city FROM customers GROUP BY customers.city HAVING NoOfCustomers > 1 ORDER BY 2 DESC

-- without having

SELECT employees.first_name,COUNT(orders.employee_id) AS totalOrders FROM orders RIGHT JOIN employees ON employees.id = orders.employee_id GROUP BY employees.first_name ORDER BY 1 DESC

-- with having

SELECT employees.first_name,COUNT(orders.employee_id) AS totalOrders FROM orders RIGHT JOIN employees ON employees.id = orders.employee_id GROUP BY employees.first_name HAVING totalOrders > 2 ORDER BY 1 DESC

-- with where

SELECT employees.first_name,COUNT(orders.employee_id) AS totalOrders FROM orders RIGHT JOIN employees ON employees.id = orders.employee_id WHERE employees.first_name = 'Nancy' OR employees.first_name = 'Jan' GROUP BY employees.first_name HAVING totalOrders > 2 ORDER BY 1 DESC

-- ANY sub query

SELECT products.product_name
FROM products
WHERE products.id = ANY
(SELECT order_details.product_id
FROM order_details
WHERE order_details.quantity > 10)


SELECT DISTINCT products.product_name
FROM products
INNER JOIN order_details
ON products.id = order_details.product_id
WHERE order_details.quantity>10

-- ALL sub query

SELECT products.product_name
FROM products
WHERE products.id = ALL
(SELECT order_details.product_id
FROM order_details
WHERE order_details.quantity > 10)

-- case when
-- aliasing

SELECT order_details.order_id, order_details.quantity,
CASE 
WHEN order_details.quantity > 30 THEN 'The quantity is greater than 30'
WHEN order_details.quantity = 30 THEN 'The quantity is 30'
ELSE 'The quantity is under 30'
END 
AS QuantityText
FROM order_details

UPDATE `suppliers` SET `country_region` = 'India' WHERE `suppliers`.`id` = 3;

UPDATE `suppliers` SET `city` = 'NewYork', `country_region` = 'NY' WHERE `suppliers`.`id` = 4;

SELECT suppliers.first_name, suppliers.city, suppliers.country_region
FROM suppliers
ORDER BY
(CASE
    WHEN suppliers.city IS NULL THEN suppliers.country_region
    ELSE suppliers.city
END)

-- Exists 
SELECT DISTINCT(employee_id) FROM `orders`
SELECT * FROM `employees`

SELECT employees.first_name
FROM employees
WHERE EXISTS
(
SELECT orders.employee_id
FROM orders
WHERE orders.employee_id = employees.id
)

SELECT employees.first_name
FROM employees
WHERE NOT EXISTS
(
SELECT orders.employee_id
FROM orders
WHERE orders.employee_id = employees.id
)