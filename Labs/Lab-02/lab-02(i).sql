select * from customers  --	question 1
where city = 'New York'
ORDER BY cust_name ASC;

select * from customers --q2
where cust_name LIKE '%John%' AND city IN ('London' , 'Paris' , 'New York');

select *from customers --q3
where city = 'London' OR city = 'New York';

select * from orders --q4
where purch_amt > 500 OR purch_amt = 500 ;

select * from salesman --q5
where  name LIKE '_a%';

UPDATE salesman --Q6
SET commision = commision + 0.5;
select * from salesman;

select * from salesman
where city = 'San Jose';

select * from orders --Q7
 ORDER BY ord_date DESC;

 select name AS firstname FROM salesman; --q8

 select * from orders -- Q9
 where MONTH(ord_date)= 1;
 --Q10
select *from orders
where MONTH(ord_date)=10;

select customer_id --q12
from orders
where YEAR(ord_date)=2012
INTERSECT
select customer_id
from orders
where YEAR(ord_date)=2014;

select customer_id --q13
from orders
where YEAR(ord_date)=2011
union
select customer_id
from orders
where YEAR(ord_date)=2013;

select customer_id --q14
from orders
where YEAR(ord_date)=2012
EXCEPT
select customer_id
from orders
where YEAR(ord_date)=2014;


