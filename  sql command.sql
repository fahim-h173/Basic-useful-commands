use sql_store;
 -- select clause
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




























