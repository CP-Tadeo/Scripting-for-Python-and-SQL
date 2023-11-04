/*
	This is the template for the SQL Hands-On Activity Solution.
	Norberto Tadeo (194796)
	October 11, 2022

	I have not discussed the SQL language code in my program 
	with anyone other than my instructor or the teaching assistants 
	assigned to this course.

	I have not used SQL language code obtained from another student, 
	or any other unauthorized source, either modified or unmodified.

	If any SQL language code or documentation used in my program 
	was obtained from another source, such as a textbook or website, 
	that has been clearly noted with a proper citation in the comments 
	of my program.
    
    Using LIMIT - https://www.w3schools.com/mysql/mysql_limit.asp
    Using AVG() - https://www.tutorialspoint.com/mysql/mysql-avg-function.htm#:~:text=MySQL%20AVG%20function%20is%20used,a%20field%20in%20various%20records.&text=You%20can%20take%20average%20of,typed%20pages%20by%20every%20person.
*/

-- 1. title of the most expensive computer book

SELECT book.title Title, book.retail Price, publisher.name AS 'Publisher Name'
FROM book, publisher
WHERE category = 'computer'
AND book.pubID = publisher.pubID
ORDER BY retail DESC LIMIT 1;

-- 2. customers who referred other customers

SELECT DISTINCT referred.referredby AS 'Customer number', CONCAT(referrer.firstname,' ', referrer.lastname) AS "Customer Name"
FROM customer referred, customer referrer
WHERE referred.referredby = referrer.customerno;

-- 3. books priced higher than the average price

SELECT book.ISBN, book.title AS 'Book Title', publisher.name AS 'Publisher', book.retail AS 'Retail Price'
FROM book, publisher
WHERE book.retail > (SELECT AVG(retail) FROM book)
AND book.pubID = publisher.pubID;

-- 4. titles bought by Bonita Morales

SELECT DISTINCT book.ISBN, book.title AS 'Book Title', book.retail AS 'Retail Price'
FROM book, customer, orderitem, orders
WHERE customer.lastname = 'Morales'
AND customer.firstname = 'Bonita'
AND orders.customerno = customer.customerno
AND orderitem.orderno = orders.orderno
AND book.ISBN = orderitem.ISBN;

-- 5. publisher of books written by author Tamara Kzochsky

SELECT DISTINCT book.title, book.category, publisher.name, publisher.contact, publisher.phone
FROM book, publisher, author, bookauthor
WHERE author.lname = 'Kzochsky'
AND author.fname = 'Tamara'
AND bookauthor.authorid = author.authorID
AND book.ISBN = bookauthor.ISBN
AND publisher.pubID = book.pubID;

-- 6. books published by the publisher of the book "Big Bear and Little Dove" that generate more profit than the average profit from all books

SELECT DISTINCT book.ISBN, book.title, book.category
FROM book, publisher, book original
WHERE (book.retail-book.cost) > (SELECT AVG(book.retail - book.cost) FROM book)
AND original.title = "Big Bear and Little Dove"
AND book.pubID = original.pubID
AND publisher.pubID = book.pubID;

-- 7. books more expensive than the most expensive cooking book

SELECT DISTINCT book.ISBN, book.title, book.category, book.retail
FROM book
WHERE book.retail > (SELECT retail FROM book WHERE book.category = 'Cooking' ORDER BY retail DESC LIMIT 1);

-- 8. books that have not been ordered at all

SELECT DISTINCT book.ISBN, book.title, book.category, book.retail
FROM book, orderitem notordered, orderitem ordered
WHERE book.ISBN NOT IN (SELECT orderitem.ISBN FROM orderitem WHERE orderitem.quantity > 0);

-- 9. orders shipped on the same date as orders of Steve Schell
-- Determine which orders were shipped to the same state as the orders of Steve Schell. (8 pts)

SELECT DISTINCT orders.orderno AS 'Order Number', orders.shipdate AS 'Date of Shipping', CONCAT(customer.firstname, ' ', customer.lastname) AS "Customer's name"
FROM orders, customer
-- WHERE orders.shipdate = (SELECT orders.shipdate FROM orders, customer WHERE customer.lastname = 'Schell' AND customer.firstname ='Steve' AND orders.customerno = customer.customerno)
WHERE orders.shipstate = (SELECT orders.shipstate FROM orders, customer WHERE customer.lastname = 'Schell' AND customer.firstname ='Steve' AND orders.customerno = customer.customerno)
AND customer.customerno = orders.customerno
AND customer.lastname != 'Schell';
-- 10. sutomers who ordered the least expensive books

SELECT DISTINCT CONCAT(customer.firstname, ' ', customer.lastname) AS 'customer', customer.state
FROM orders, orderitem, customer, book
WHERE book.retail = (SELECT retail FROM book ORDER BY retail LIMIT 1)
AND orderitem.ISBN = book.ISBN
AND orders.orderno = orderitem.orderno 
AND customer.customerno = orders.customerno;

-- end of solution file --  
/*
SELECT book.title, customer.firstname, customer.lastname, book.retail
FROM book, customer, orders, orderitem
WHERE customer.firstname = 'WILLIAM'
AND orders.customerno = customer.customerno
AND orderitem.orderno = orders.orderno
AND book.ISBN = orderitem.ISBN;
*/
