create database Ecommerce

select *from customers
select *from order_items
select *from orders
select *from products
select *from payments

--JOINS------------------------------------------------------------------------------------------

--Order details with customer names
SELECT o.*, c.first_name, c.last_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id;

--Order items with  name, quantity, and subtotal
SELECT oi.order_id, p.product_name, oi.quantity, oi.subtotal
FROM order_items oi
JOIN products p 
ON p.product_id = oi.product_id;

-- Payment transactions with order details
SELECT p.payment_id, p.payment_method, p.payment_status, o.*
FROM payments p
JOIN orders o 
ON o.order_id = p.order_id;

--Customers who never placed an order
SELECT c.*
FROM customers c
Left JOIN orders o 
ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

--Products never purchased -- doubt
SELECT p.*
FROM products p
LEFT JOIN order_items oi 
ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

--Customers and total spending across orders
SELECT c.customer_id, c.first_name,c.last_name, sum(o.total_amount) as total_spending
from customers c
join orders o
on c.customer_id = o.customer_id
group by
c.customer_id, c.first_name,c.last_name

--Get the total number of products ordered by each customer. 
select o.customer_id, sum(oi.quantity) as t_p_o
from order_items oi
join orders o
on oi.order_id = o.order_id
group by
o.customer_id

select c.customer_id, c.first_name, o.order_id, sum(oi.quantity) as t_p_o
from customers as c
inner join orders as o on c.customer_id = o.customer_id
inner join order_items as oi on o.order_id = oi.order_id
group by c.customer_id, c.first_name, o.order_id

--Display all orders along with the names of the products included in each order. 8
select oi.order_id, p.product_name, oi.quantity
from order_items oi
join products p
on oi.product_id = p.product_id

SELECT o.order_id, o.order_date, p.product_name,
 oi.quantity, oi.subtotal
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
ORDER BY o.order_id, p.product_name;

--9
SELECT o.*
FROM orders o
LEFT JOIN payments p ON p.order_id = o.order_id
WHERE p.payment_id IS NULL;

--10
SELECT c.customer_id, c.first_name, c.last_name,
 MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o 
ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY last_order_date DESC;

-----------------------------------------------------------------------------------------------------
select * from customers

select customer_id , first_name, email
from customers

--Products in Clothing
select product_name
from products
where category = 'clothing';

select *from customers
select *from order_items
select *from orders
select *from products
select *from payments

-- Orders over $500
select order_id
from orders
where total_amount > 500

--Customers who joined after January 1, 2023
SELECT *
FROM customers
WHERE join_date > '2023-01-01';

--Five most expensive products
SELECT TOP 5 *
FROM products
ORDER BY price DESC;


--Ten latest orders
SELECT TOP 10 *
FROM orders
ORDER BY order_date DESC;

-- Completed orders
SELECT *
FROM orders
WHERE order_status = 'Completed';

--Orders placed in February 2023
SELECT *
FROM orders
WHERE order_date >= '2023-02-01'
 AND order_date < '2023-03-01';

 --Products priced from $50 to $100, inclusive
SELECT *
FROM products
WHERE price BETWEEN 50 AND 100;
----------------------------------------------------------------------------------------------------

--Total customer count
select count(customer_id)
from customers

--Average order amount
SELECT AVG(total_amount) 
FROM orders;

-- Highest and lowest priced products
SELECT TOP 1 *
FROM products
ORDER BY price DESC;
SELECT TOP 1 *
FROM products
ORDER BY price ASC;

--Product count by category
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category
ORDER BY category;

--Total revenue from orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;

--Orders per customer, highest first
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

--Revenue by month in 2023
SELECT
    MONTH(Order_Date) AS Month,
    SUM(total_Amount) AS Total_Revenue
FROM Orders
WHERE YEAR(Order_Date) = 2023
GROUP BY MONTH(Order_Date)
ORDER BY MONTH(order_date);

--Customers with more than five orders
SELECT
    Customer_ID,
    COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) > 5
ORDER BY Total_Orders DESC;

--Most frequently used payment method
SELECT TOP 1
    Payment_Method,
    COUNT(*) AS Total_Uses
FROM payments
GROUP BY Payment_Method
ORDER BY COUNT(*) DESC;

--Average product price by category
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category
ORDER BY category;
------------------------------------------------------------------------------------------------------
select o.order_id, o.order_date, count(Distinct oi.product_id) as diff_prod
from order_items oi
join orders o
on oi.order_id = o.order_id
group by o.order_id, o.order_date

select Distinct c.customer_id, c.first_name--, p.category
from orders o
join customers c on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
where p.category = 'Books'

------------------------------------------------------------------------------------------------
select o.order_id, c.first_name, c.last_name     --1
from orders o 
join customers c
on o.customer_id = c.customer_id

select o.order_date, c.first_name
from orders o
join customers c
on o.customer_id = c.customer_id                     --2

select oi.order_id, p.product_name, oi.quantity, oi.subtotal           --3
from order_items oi
join products p
on oi.product_id = p.product_id

select oi.order_id, p.payment_id , p.payment_method
from order_items oi
join payments p                                   --4
on oi.order_id = p.order_id 

select o.order_id, c.first_name, c.email
from orders o                                      --5
join customers c
on o.customer_id = c.customer_id

select oi.order_id, p.product_name
from order_items oi                                               --6
join products p
on oi.product_id = p.product_id

select c.first_name, o.order_id
from orders o                                                               --7
join customers c
on o.customer_id = c.customer_id

select count(order_id)
from orders

select c.first_name
from orders o                                                               --8
left join customers c
on o.customer_id = c.customer_id
where o.order_id is NULL

select o.order_id, p.payment_status
from orders o                                                               --9
join payments p
on o.order_id = p.order_id

SELECT c.first_name, c.last_name, p.product_name,oi.quantity
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id                                         --10
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id;


-------------------WINDOW FXns QUESTIONS----------------------------------

with chk as (select * ,Row_number() over (order by order_date asc) as row_no
from orders)
select * from chk 
where row_no = 2

select * , count(*) over() as total_orders
from orders

select *, max(total_amount) over () as hoa
from orders


select * , count(*) over ( partition by customer_id) as c_o_c
from orders

select * , avg(total_amount) over ( partition by customer_id) as aaa
from orders


select * , rank() over ( partition by customer_id order by total_amount desc) as order_rank
from orders

select * , row_number() over ( partition by customer_id order by order_date asc ) as c_o_n
from orders

--------------------------------------------------------------------------------------------
select * from orders

select month(order_date), round(sum(total_amount),2),
round(lag(sum(total_amount)) over (order by month(order_date)),2) as pmd,
round(sum(total_amount) - lag(sum(total_amount)) over (order by month(order_date)),2) as p_l,
round((sum(total_amount) - lag(sum(total_amount)) over (order by month(order_date)))
/lag(sum(total_amount)) over (order by month(order_date))*100,2)
from orders
group by month(order_date)

    
--> round function to remove extra decimal values 
--> lag and lead function must use with order by
--> offset of 2 means jump before 2 or after 2 values for lag and lead
