/*
	This is the template for the SQL Hands-On Test Solution.
	Norberto Tadeo (194796)
	25 October 2022

	I have not discussed the SQL language code in my program 
	with anyone other than my instructor or the teaching assistants 
	assigned to this course.

	I have not used SQL language code obtained from another student, 
	or any other unauthorized source, either modified or unmodified.

	If any SQL language code or documentation used in my program 
	was obtained from another source, such as a textbook or website, 
	that has been clearly noted with a proper citation in the comments 
	of my program.
*/

-- 1. create the three tables
#create CLIENT, ROOM, RESERVES
#Not specified in the specs but will do it anyway
DROP DATABASE PACIFIC_SPIRE_HOTEL;
CREATE DATABASE PACIFIC_SPIRE_HOTEL;
USE PACIFIC_SPIRE_HOTEL;

#Place Item 1 SQL Statements here
CREATE TABLE client(
clientno INT UNIQUE PRIMARY KEY,
lastname VARCHAR(15),
firstname VARCHAR(15),
address VARCHAR(255)
);

CREATE TABLE room(
roomno INT UNIQUE PRIMARY KEY,
inclusions VARCHAR(255),
rate INT,
roomtype CHAR(25),
CHECK (roomtype IN ('Single', 'Twin','Double','Suite'))
);

CREATE TABLE reserves(
roomno INT NOT NULL, FOREIGN KEY (roomno) REFERENCES room(roomno),
clientno INT NOT NULL, FOREIGN KEY (clientno) REFERENCES client(clientno),
checkindate DATE,
checkoutdate DATE,
amountpaid INT,

Constraint PK_RESERVES Primary Key (roomno, clientno)
);

#SHOW TABLES;
#DESC client;
# room;
#DESC RESERVES;
-- 2. run the script to populate the tables

#Place Item 2 SQL Statement here

INSERT INTO client
VALUES (3011,'SCIUTO','ABBY','NCIS, WASHINGTON');

INSERT INTO client
VALUES (3008,'LUND','SEBASTIAN','NCIS, NEW ORLEANS');

INSERT INTO client
VALUES (3002,'JONES','NELL','NCIS, LOS ANGELES');

INSERT INTO client
VALUES (3003,'GARCIA','PENELOPE','BAU, QUANTICO');

INSERT INTO client
VALUES (3007,'REID','SPENCER','BAU, QUANTICO');

INSERT INTO client
VALUES (3001,'MACGYVER','ANGUS','PHOENIX FOUNDATION, LOS ANGELES');

INSERT INTO client
VALUES (3005,'BROWN','KARAMO','FAB 5 LOFT, ATLANTA');

INSERT INTO client
VALUES (3006,'QUEEN','OLIVER',', QUEEN CONSOLIDATED, STARLING CITY');

INSERT INTO client
VALUES (3004,'DIAZ','ROSA','BROOKLYN 99, NEW YORK');

INSERT INTO client
VALUES (3009,'RAMSAY','GORDON','HELLS KITCHEN, NEW YORK');

INSERT INTO client
VALUES (3010,'CAGE','LUKE','HARLEM, NEW YORK');

INSERT INTO client
VALUES (3012,'SCOTT','MICHAEL','SCRANTON, PENNSYLVANIA');

INSERT INTO room
VALUES (7001,'SET BREAKFAST FOR 2',5986,'Double');

INSERT INTO room
VALUES (7002,'BUFFET BREAKFAST FOR 2, KITCHENETTE, BATH TUB',13411,'Suite');

INSERT INTO room
VALUES (7003,'BUFFET BREAKFAST FOR 2, BATH TUB',6555,'Double');

INSERT INTO room
VALUES (7004,'BUFFET BREAFKAST FOR 1, BATH TUB',3118,'Single');

INSERT INTO room
VALUES (7005,'SET BREAKFAST FOR 2, BATH TUB',11146,'Suite');

INSERT INTO room
VALUES (7006,'SET BREAKFAST FOR 2, BATH TUB',11949,'Suite');

INSERT INTO room
VALUES (7007,'BUFFET BREAKFAST FOR 2, BATH TUB',8643,'Double');

INSERT INTO room
VALUES (7008,'SET BREAKFAST FOR 2',6075,'Double');

INSERT INTO room
VALUES (7009,'SET BREAKFAST FOR 2, BATH TUB',11376,'Suite');

INSERT INTO room
VALUES (7010,'SET BREAKFAST FOR 2',7447,'Twin');

INSERT INTO room
VALUES (7011,'SET BREAKFAST FOR 2',5668,'Double');

INSERT INTO room
VALUES (7012,'SET BREAKFAST FOR 2',5234,'Double');

INSERT INTO room
VALUES (7013,'SET BREAKFAST FOR 2, BATH TUB',11248,'Suite');

INSERT INTO room
VALUES (7014,'SET BREAKFAST FOR 2',6056,'Double');

INSERT INTO room
VALUES (7015,'SET BREAKFAST FOR 2, BATH TUB',8340,'Twin');

INSERT INTO room
VALUES (7016,'SET BREAKFAST FOR 2, BATH TUB',11192,'Suite');

INSERT INTO room
VALUES (7017,'SET BREAKFAST FOR 1',2513,'Single');

INSERT INTO room
VALUES (7018,'SET BREAKFAST FOR 1',2254,'Single');

INSERT INTO room
VALUES (7019,'BUFFET BREAKFAST FOR 2',6923,'Double');

INSERT INTO room
VALUES (7020,'BUFFET BREAKFAST FOR 2, BATH TUB',9342,'Twin');

INSERT INTO reserves
VALUES (7011,3002,'2017-01-05','2017-01-08',16611);

INSERT INTO reserves
VALUES (7019,3001,'2017-01-05','2017-01-11',44444);

INSERT INTO reserves
VALUES (7014,3010,'2016-12-27','2016-12-28',6400);

INSERT INTO reserves
VALUES (7013,3011,'2016-12-28','2017-01-04',66000);

INSERT INTO reserves
VALUES (7007,3011,'2016-12-26','2016-12-28',20450);

INSERT INTO reserves
VALUES (7004,3006,'2017-01-04','2017-01-07',15200);

INSERT INTO reserves
VALUES (7019,3004,'2016-12-25','2016-12-31',45454);

INSERT INTO reserves
VALUES (7003,3011,'2016-12-28','2016-12-30',15128);

INSERT INTO reserves
VALUES (7004,3005,'2017-01-05','2017-01-08',15052);

INSERT INTO reserves
VALUES (7001,3010,'2016-12-30','2017-01-02',16161);

INSERT INTO reserves
VALUES (7001,3009,'2017-01-04','2017-01-07',15515);

INSERT INTO reserves
VALUES (7020,3008,'2016-12-26','2016-12-30',36000);

INSERT INTO reserves
VALUES (7007,3012,'2016-12-26','2016-12-29',22850);

INSERT INTO reserves
VALUES (7011,3004,'2017-01-06','2017-01-08',16610);

INSERT INTO reserves
VALUES (7007,3006,'2017-01-02','2017-01-05',22850);

INSERT INTO reserves
VALUES (7008,3012,'2017-01-03','2017-01-05',13210);

INSERT INTO reserves
VALUES (7011,3005,'2017-01-05','2017-01-08',18810);

INSERT INTO reserves
VALUES (7004,3002,'2017-01-02','2017-01-07',15200);

-- 3. find necessary client numbers and room numbers, and create records in the RESERVES table
#SELECT clientno FROM client WHERE lastname = 'MacGyver' AND firstname = 'Angus';
INSERT INTO reserves (roomno, clientno, checkindate, checkoutdate, amountpaid)
VALUES(7007, (SELECT clientno FROM client WHERE lastname = 'MacGyver' AND firstname = 'Angus'),
'2017-01-03', '2017-01-06', 21845);

INSERT INTO reserves (roomno, clientno, checkindate, checkoutdate, amountpaid)
VALUES(7006, (SELECT clientno FROM client WHERE lastname = 'Diaz' AND firstname = 'Rosa'),
'2017-01-05', '2017-01-12', 72782);
####No answer for display for 3 :((
/*
SELECT CONCAT(client.lastname, ' ', client.firstname), room.roomno, reserves.checkindate,
reserves.checkoutdate, reserves.amountpaid
FROM client, reserves, room
WHERE room.r
*/


-- 4. most expensive rate per night

SELECT DISTINCT room.roomno 'Room', room.roomtype 'Room Type', room.rate 'Rate Per Night'
FROM room
ORDER BY room.rate DESC LIMIT 1;

-- 5. rooms not yet reserved, according to rate per night

#Place Item 5 SQL Statement here
SELECT DISTINCT room.roomno 'Unreserved', room.inclusions 'Room Inclusions', room.roomtype 'Room Type', room.rate 'Rate'
FROM room, reserves
WHERE (room.roomno NOT IN (SELECT room.roomno FROM room, reserves WHERE room.roomno = reserves.roomno))
ORDER BY room.rate;

-- 6. rooms reserved by clients from NY, according to check-in date

SELECT DISTINCT  CONCAT(client.firstname, ' ', client.lastname) 'Client', client.address, room.roomno 'Room', reserves.checkindate 'Check-in'
FROM room, client, reserves
WHERE client.address LIKE '%New York%'
AND reserves.clientno = client.clientno
AND room.roomno = reserves.roomno
ORDER BY checkindate;
-- 7. clients reserved a room with a tub checked in after NYD 2017, according to check-in date then full name

SELECT DISTINCT  CONCAT(client.firstname, ' ', client.lastname) 'Client', room.roomno 'Room with Tub', reserves.checkindate 'Check-in', reserves.checkoutdate 'Check-out'
FROM client, room, reserves
WHERE room.inclusions LIKE '%Bath Tub%'
AND reserves.checkindate > '2017-01-01'
AND reserves.roomno = room.roomno
AND client.clientno = reserves.clientno
ORDER BY reserves.checkindate, CONCAT(client.firstname, ' ', client.lastname);
-- 8. summary of total sales per room type, highest to lowest sales

SELECT DISTINCT room.roomtype 'Room Type', ROUND(count(room.roomtype)/12) AS 'Times Booked', ROUND(sum(reserves.amountpaid)/12) AS 'Sales'
FROM room, client, reserves
WHERE room.roomno = reserves.roomno
group by room.roomtype
ORDER BY sum(reserves.amountpaid)/12 DESC;



-- end of solution file --