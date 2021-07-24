# Northwind Database
use northwind;

# Q.1 Write a query to get Product name and quantity/unit
SELECT PRODUCTNAME, QUANTITYPERUNIT FROM PRODUCTS;

# Q.2 Write a query to get current Product list (Product ID and name)
SELECT PRODUCTID, PRODUCTNAME FROM PRODUCTS
WHERE DISCONTINUED = 0;

# Q.3 Write a query to get discontinued Product list (Product ID and name)
SELECT PRODUCTID, PRODUCTNAME FROM PRODUCTS
WHERE DISCONTINUED = 1;

# Q.4 Write a query to get most expense and least expensive Product list (name and unit price)
SELECT ProductName, UnitPrice 
FROM Products 
ORDER BY UnitPrice DESC;

# Q.5 Write a query to get Product list (id, name, unit price) where current products cost less than $20
SELECT PRODUCTID, PRODUCTNAME, UNITPRICE FROM PRODUCTS 
WHERE DISCONTINUED = 0 
AND UNITPRICE<20;

# Q.6 Write a query to get Product list (id, name, unit price) where products cost between $15 and $25
SELECT PRODUCTID, PRODUCTNAME, UNITPRICE FROM PRODUCTS
WHERE UNITPRICE BETWEEN 15 AND 25;

# Q.7 Write a query to get Product list (name, unit price) of above average price
#SELECT AVG(UNITPRICE) FROM PRODUCTS;
SELECT PRODUCTNAME, UNITPRICE FROM PRODUCTS
WHERE UNITPRICE > (SELECT AVG(UNITPRICE) FROM PRODUCTS)
ORDER BY UNITPRICE;

# Q.8 Write a query to get Product list (name, unit price) of ten most expensive products
SELECT DISTINCT PRODUCTNAME AS TOP_TEN_EXPENSIVE_PRODUCTS, UNITPRICE
FROM PRODUCTS AS PROA
WHERE 10 >= (SELECT COUNT(DISTINCT UNITPRICE)
				FROM PRODUCTS AS PROB
                WHERE PROB.UNITPRICE >= PROA.UNITPRICE)
ORDER BY UNITPRICE DESC;

# Q.9 Write a query to count current and discontinued products
SELECT COUNT(PRODUCTNAME) FROM PRODUCTS
GROUP BY DISCONTINUED;

# Q.10 Write a query to get Product list (name, units on order , units in stock) 
# of stock is less than the quantity on order
SELECT PRODUCTNAME, UNITSONORDER, UNITSINSTOCK FROM PRODUCTS
WHERE (((DISCONTINUED)=FALSE) AND (UNITSINSTOCK < UNITSONORDER));
