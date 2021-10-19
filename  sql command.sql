use sql_store;
 -- select clause

SELECT first_name, last_name, points, points + 10 FROM customers;




SELECT 
	first_name, 
    last_name,
    points,
    points+10,
    (points+10)*2 AS 'Discount Price'
FROM customers;

SELECT name,unit_price,unit_price*1.1 as 'with vat' from products;

-- where clause
SELECT * FROM customers WHERE points > 3000;

-- comparator oparators in sql
-- > is called greater than oparator
-- >= is called greater equal oparator
-- < is called less than oparator
-- < is called less equal oparator
-- = is called  equal oparator
-- != is called not equal oparator
-- <> is called not equal oparator
SELECT * FROM customers WHERE birth_date >= '1990-01-01' OR points > 1000; -- show result if a single condition is true

SELECT * FROM customers WHERE birth_date >= '1990-01-01' AND points > 1000; -- show result if all conditions are true

-- AND is more priority than OR




SELECT * FROM customers WHERE birth_date >= '1990-01-01' OR points > 1000 AND state = 'va'; 

SELECT * FROM customers WHERE NOT (birth_date > '1990-01-01' OR points > 1000); -- the use of not is oposite of all oparetors

SELECT * FROM order_items WHERE order_id = 6 AND unit_price*quantity > 30;

-- in oparetor (it's an easy solution for OR oparetor)

SELECT * FROM products WHERE quantity_in_stock IN (49,38,72)



-- between operatior


SELECT * FROM customers WHERE points >= 1000 AND points<=3000;

SELECT * FROM customers WHERE points BETWEEN 1000 AND 3000;


SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- The like operator it's shows us a pattern

SELECT * FROM customers WHERE last_name LIKE 'b%'; -- it return b as a first letter

SELECT * FROM customers WHERE last_name LIKE '%b%'; --it's return us b in anywhere
SELECT * FROM customers WHERE last_name LIKE '%y'; -- it will return last name with y


SELECT * FROM customers WHERE last_name LIKE '_y'; -- it will return two charector name with y and _ will increase is value 

SELECT * FROM customers WHERE address LIKE '%TRAIL%' OR '%AVENUE%' -- find trail and avenue keyword in address


SELECT * FROM customers WHERE phone NOT LIKE '%9'

-- REGEXP Oparetor


SELECT * FROM customers WHERE last_name REGEXP 'field' -- we don't have to type % in like oparator
-- also ^ it reprasant the word shuld be first position and $ reprasant the word should be last position 
-- and without special charectar means any position

-- we can search multiple words using | (pipe)
SELECT * FROM customers WHERE last_name REGEXP 'field|mac'
-- also we can combine this like below
SELECT * FROM customers WHERE last_name REGEXP '^field|mac|rose';
SELECT * FROM customers WHERE last_name REGEXP 'field$|mac|rose';

SELECT * FROM customers WHERE last_name REGEXP '[gim]e' -- before 'e' it must have [gim]'s any value also we set this for after value also we can set value [a-h] like this. it means a to h

SELECT * FROM customers WHERE last_name REGEXP 'b[ru]' -- name contains b followed by r and u

-- the IS NULL Oparetor [null means an absanse of value]

SELECT * FROM customers WHERE phone IS NULL; --  find a person who does't have phone number so that we can send an email for ask his phone number

SELECT * FROM customers WHERE phone IS NOT NULL;

-- The ordered by operator

-- exercise 
SELECT * FROM order_items WHERE order_id=2 ORDER BY quantity*unit_price;
SELECT *,quantity* unit_price AS total_price FROM order_items WHERE order_id=2 ORDER BY total_price DESC;



-- The limit oparetor

SELECT * FROM customers LIMIT 3; -- for limited result
SELECT * FROM customers LIMIT 5,2; -- the first number for skip rows and the second number is for showing rows

-- exercies : find top 3 most loyal customar

SELECT * FROM customers ORDER BY points DESC LIMIT 3;

-- the structure is 

SELECT * FROM customers WHERE ORDER BY points DESC LIMIT 3;

-- inner joins and join [on means condition in join]

SELECT * FROM orders JOIN customers ON orders.customer_id=customers.customer_id;

SELECT order_id,first_name,last_name,orders.customer_id FROM orders JOIN customers ON orders.customer_id=customers.customer_id; -- manual column

SELECT * FROM order_items JOIN products ON order_items.product_id = products.product_id;

SELECT order_id,order_items.product_id,quantity,order_items.unit_price FROM order_items JOIN products ON order_items.product_id = products.product_id;


-- joing across databases

 SELECT * FROM order_items JOIN sql_inventory.products ON order_items.order_id=products.product_id;


USE sql_inventory;
 
 SELECT * FROM sql_store.order_items oi JOIN products p ON oi.product_id=p.product_id;

-- self joins

USE sql_hr;

SELECT * FROM employees e JOIN employees m ON e.reports_to = m.employee_id

USE sql_hr;

SELECT e.employee_id,
	   e.first_name,
       m.first_name AS manager
FROM employees e JOIN employees m ON e.reports_to = m.employee_id; -- manual column


-- joining multiple table

USE sql_store;

USE sql_store;

SELECT *
       os.name AS status
		FROM orders o JOIN customers c ON o.customer_id=c.customer_id
		JOIN order_statuses os ON o.status=os.order_status_id; -- all column

SELECT o.order_id,
	   o.order_date,
       c.first_name,
       c.last_name,
       os.name AS status
		FROM orders o JOIN customers c ON o.customer_id=c.customer_id
		JOIN order_statuses os ON o.status=os.order_status_id; -- manual column


-- excercise 
USE sql_invoicing;

SELECT p.date,
	   p.invoice_id,
       p.amount,
       c.name,
       pm.name
       FROM payments p JOIN clients c ON p.client_id=c.client_id
		JOIN payment_methods pm ON p.payment_method=pm.payment_method_id;



-- compound join condition

SELECT * FROM order_items oi JOIN order_item_notes oin ON oi.order_id = oin.order_Id AND oi.product_id=oin.product_id;

-- implicit join syntax

SELECT * FROM orders o , customers c WHERE o.customer_id = c.customer_id; -- awar of for this joing instate, use belew query
SELECT * FROM orders o JOIN customers c ON o.customer_id = c.customer_id;


-- outer join

SELECT 
		c.customer_id,
        c.first_name,
        o.order_id
        FROM customers c JOIN orders o ON c.customer_id = o.customer_id
        	ORDER BY c.customer_id; -- it does't show any customers who don't have any order;

-- in sql we have left join and right join


SELECT 
		c.customer_id,
        c.first_name,
        o.order_id
        FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
        	ORDER BY c.customer_id; -- it will show all the customers from the left (customers) table records and the 'Right' join will show all the records from the right table(orders) also it'll show all the customers and orders

SELECT 
		c.customer_id,
        c.first_name,
        o.order_id
        FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id
        	ORDER BY c.customer_id; -- it will show all the records from right table (orders). it will show all the orders not all the customers.


-- excercise with order and outer join
SELECT p.product_id,
	   p.name,
       oi.quantity
       FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id;--  it will show all result from the left table whether the condition is true or not we can see stil see the result

-- outer join between multiple table 

SELECT 
		c.customer_id,
        c.first_name,
        o.order_id
        FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
        	JOIN shippers sh ON o.shipper_id = sh.shipper_id
        	ORDER BY c.customer_id; -- the result will show only the records which have shipper_id;


SELECT 
		c.customer_id,
        c.first_name,
        o.order_id
        FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
        	LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id
        	ORDER BY c.customer_id; -- NOW we can see the order without shipper id;


SELECT 
		c.customer_id,
        c.first_name,
        o.order_id,
        sh.name as shipper
        FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
        	LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id
        	ORDER BY c.customer_id; -- sh.name to shipper column added;

-- excercise for this query

SELECT 
		c.customer_id,
        
        o.order_id,
        o.order_date,
        sh.name as shipper,
        c.first_name AS customer,
        os.name AS STATUS
        FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
        	LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id
            JOIN order_statuses os ON o.status=os.order_status_id
        	ORDER BY c.customer_id;



-- selt outer join
 USE sql_hr;
SELECT  e.employee_id,
		e.first_name,
        m.first_name AS manager
		FROM employees e LEFT JOIN employees m ON e.reports_to = m.employee_id 


-- USING Operator

 USE sql_hr;
SELECT  e.employee_id,
		e.first_name,
        m.first_name AS manager
		FROM employees e LEFT JOIN employees m ON e.reports_to = m.employee_id -- we can use USING operator instade of (ON e.reports_to = m.employee_id) if the culumn name is equal 


-- excercise 
USE sql_invoicing;
SELECT * FROM payments p JOIN clients c USING (client_id)
		JOIN payment_methods pm
        ON p.payment_method=pm.payment_method_id; -- for all column;

USE sql_invoicing;
SELECT 
		p.date,
        c.name AS client,
        p.amount,
        pm.name as payment_method
        FROM payments p JOIN clients c USING (client_id)
		JOIN payment_methods pm
        ON p.payment_method=pm.payment_method_id; -- for indibisual column

-- *natural join

SELECT * FROM orders o NATURAL JOIN customers c; -- it will join common column some times it could show unexpected result;

-- *cross join

SELECT c.first_name AS customer,
		p.name as product
        FROM customers c CROSS JOIN products p
        ORDER BY c.first_name;

-- *cross join 'implicit syntex'

SELECT sh.name AS shipper,
		p.name AS product 
		FROM shippers sh, products p ORDER BY sh.name;

-- *cross join explicit syntex

SELECT sh.name AS shipper,
		p.name AS product 
		FROM shippers sh CROSS JOIN products p ORDER BY sh.name;


-- *** UNION We can join multiple rows in sql

SELECT order_id,
		order_date,
        'Active'as status 
        FROM orders WHERE order_date >='2019-01-01'
 UNION      
SELECT order_id,
		order_date,
        'Archived'as status 
        FROM orders WHERE order_date <='2019-01-01'

-- we have to maintain the column number

SELECT first_name FROM customers 
UNION 
SELECT name FROM shippers

-- union excercise

SELECT customer_id,first_name,points,'Bronze' AS type FROM customers WHERE points <= 2000
UNION
SELECT customer_id,first_name,points,'Silver' AS type FROM customers WHERE points >2000
UNION
SELECT customer_id,first_name,points,'Golden' AS type FROM customers WHERE points > 3000 ORDER BY customer_id; -- finaly we have done an amazing job by listing rows and marks our customers;

-- *** column Atrribute [now we have to learn ho to insert data , update and remove]


INSERT INTO customers VALUE(DEFAULT,
						'Muhammad',
                        'Fahim',
                        '1998-04-01',
                        '+880-1518-399106',
                        'address',
                        'city',
                        'BD',DEFAULT);

INSERT INTO customers(  customer_id,
                        first_name,
                        last_name,
                        birth_date,
                        phone,
                        address,
                        city,
                        state,
                        points
                        ) VALUE(DEFAULT,
						'Muhammad',
                        'Fahim',
                        '1998-04-01',
                        '+880-1518-399106',
                        'address',
                        'city',
                        'BD',DEFAULT)



-- ** inserting multiple rows

-- ** inserting hierarchical rows [inserting data to multiple table]

INSERT INTO orders (customer_id,order_date,status) 
				VALUES(1,'2019-01-02',DEFAULT);
                
                
INSERT INTO order_items VALUES (LAST_INSERT_ID(),1,10,3.85) 


INSERT INTO orders (customer_id,order_date,status) 
				VALUES(1,'2019-01-02',DEFAULT);
                
                
INSERT INTO order_items VALUES (LAST_INSERT_ID(),1,10,3.85)
								

-- * CREATING copy of a data in sql

CREATE TABLE order_archived AS SELECT * FROM orders;


-- we can also copy specipic data to other table


INSERT INTO order_archived

SELECT * FROM orders WHERE order_date <'2019-01-01' 


USE sql_invoicing;
CREATE TABLE invoices_archived AS
SELECT i.client_id,
	   i.number,
       c.name AS client,
       i.invoice_total,
       i.payment_total,
       i.invoice_date,
       i.payment_date,
       i.due_date

		FROM invoices i JOIN clients c USING (client_id)
			WHERE payment_date IS NOT NULL; 

-- *** update data in sql

 -- update data in a single row

UPDATE invoices SET payment_total = 10,payment_date='2019-03-02'
		WHERE invoice_id=3  -- WHERE invoice_id=3 it means we are going to change number 2 row.

UPDATE invoices SET payment_total = DEFAULT,payment_date=DEFAULT
		WHERE invoice_id=3;-- if we have to return it's default value

 -- if a customer pay 50% 

USE sql_invoicing;
UPDATE invoices SET payment_total = invoice_total * 0.5,payment_date = due_date
		WHERE client_id=4

-- updating multiple rows

UPDATE invoices SET payment_total = DEFAULT,payment_date=DEFAULT
		WHERE client_id=3 -- it will update all records where sql found the same client_id number


UPDATE invoices SET payment_total = 75.87,payment_date= due_date
		WHERE client_id in (1,5); -- also we can update multiple row with condition

-- * excercise give 50 points extra customers thus who born before 190-01-01

USE sql_store;

UPDATE customers SET points=points+50 WHERE birth_date <'1990-01-01'


-- using sub querise in update

USE sql_invoicing;
UPDATE invoices SET payment_total = 85.28,payment_date = due_date
		WHERE client_id=
          (SELECT client_id 
            FROM clients 
           WHERE name='Myworks')

USE sql_invoicing;
UPDATE invoices SET payment_total = invoice_total * 0.5,payment_date = due_date
		WHERE client_id=4
                           (SELECT client_id 
                                    FROM clients 
                                      WHERE state in ('CA','NY')) -- FOR multiple values

--- ******* WHEN we have to update a query we must have to see them first then should update the statement


-- excercise 
        
            UPDATE orders SET comments = 'Golden Customers'
		WHERE customer_id IN
							(SELECT customer_id FROM customers WHERE points>3000);


-- **** row Deletion 

DELETE FROM invoices
	WHERE client_id=2;


DELETE FROM invoices
	WHERE client_id= (SELECT * FROM clients WHERE name = 'Myworks')-- not working

--- **** DELETE FROM invoices
    DELETE FROM invoices
	WHERE invoice_id=1 

-- **** Restore Database


open the same script again


















