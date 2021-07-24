create database Superstore;
USE Superstore;

# Q.1 Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen
SELECT CUSTOMER_NAME "CUSTOMER NAME", CUSTOMER_SEGMENT "CUSTOMER SEGMENT" FROM CUST_DIMEN;

# Q.2 Write a query to find all the details of the customer from the table cust_dimen order by desc
SELECT * FROM CUST_DIMEN
ORDER BY CUST_ID DESC;

# Q.3 Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high
SELECT ORDER_ID, ORDER_DATE FROM ORDERS_DIMEN
WHERE ORDER_PRIORITY = "HIGH";

# Q.4 Find the total and the average sales (display total_sales and avg_sales)
SELECT SUM(SALES) "Total_Sales", AVG(SALES) "Avg_Sales" FROM MARKET_FACT;



# Q.5 Write a query to get the maximum and minimum sales from market_fact table.
SELECT MAX(SALES), MIN(SALES) FROM MARKET_FACT;

# Q.6 Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.
# 1) query 
SELECT REGION as Region, COUNT(CUST_ID) "no_of_customers" FROM CUST_DIMEN
GROUP BY Region
ORDER BY COUNT(CUST_ID) DESC;

# 2) query -optional
SELECT REGION, COUNT(*) AS "no_of_customers" FROM CUST_DIMEN
GROUP BY REGION
ORDER BY "no_of_customers" DESC;

select count(cust_id) as no_of_cusotmers, region as Region from cust_dimen 
group by region order by count(Cust_id) DESC;

# Q.7 Find the region having maximum customers (display the region name and max(no_of_customers)
SELECT MAX(no_of_cust) "Max Customers", Region FROM(SELECT REGION, COUNT(CUST_ID) "no_of_cust" FROM CUST_DIMEN GROUP BY REGION	ORDER BY COUNT(CUST_ID) DESC) AS MAX_CUST_REGION;


select Region, count(cust_id) from cust_dimen
where max(count(cust_id))
group by region
order by count(cust_id) desc;


SELECT MAX(no_of_customers), Region 
FROM (SELECT Region , COUNT(Cust_id) "no_of_customers" 
FROM cust_dimen
GROUP BY Region ORDER BY COUNT(Cust_id) Desc ) as MAX_CUST_REGION ;



SELECT REGION, MAX(CUSTOMER_NAME) "TOTAL_CUSTOMER" FROM CUST_DIMEN
WHERE COUNT(TOTAL_CUSTOMER);
#GROUP BY REGION;
SELECT REGION, COUNT(*) "no_of_customers" FROM CUST_DIMEN
GROUP BY REGION HAVING no_of_customers >= ALL(SELECT COUNT(*) 'no_of_customers' FROM CUST_DIMEN
GROUP BY REGION);

# Q.8 Find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
#and the number of tables purchased (display the customer name, no_of_tables purchased)
SELECT CUST.CUSTOMER_NAME, CUST.REGION, PROD.PRODUCT_SUB_CATEGORY
FROM CUST_DIMEN AS CUST JOIN PROD_DIMEN AS PROD
WHERE PRODUCT_SUB_CATEGORY = "TABLES" AND REGION = "ATLANTIC";

SELECT Customer_Name, COUNT(p.Prod_id) AS 'no_of_tables_purchase' FROM market_fact m
JOIN cust_dimen c ON m.Cust_id=c.Cust_id 
JOIN prod_dimen p ON m.Prod_id = p.Prod_id
WHERE c.Region='ATLANTIC' AND p.Product_Sub_Category='TABLES' 
GROUP BY c.Customer_Name ORDER BY COUNT(c.Cust_id) DESC;

select Customer_Name, count(*) as num_tables    
 from market_fact s, cust_dimen c, prod_dimen p
     where s.Cust_id = c.Cust_id and     
s.Prod_id = p.Prod_id and      
p.Product_Sub_Category = 'TABLES' and   
  c.Region = 'ATLANTIC'     
group by Customer_Name;

# Q.9 Find all the customers from Ontario province who own Small Business. (display 
#the customer name, no of small business owners)
SELECT * FROM CUST_DIMEN
WHERE PROVINCE = "ONTARIO"
GROUP BY CUSTOMER_SEGMENT;

SELECT Customer_Name, COUNT(Customer_Name) AS 'No of small business owners' FROM cust_dimen 
WHERE Customer_Segment='SMALL BUSINESS' AND Region='ONTARIO' 
GROUP BY Customer_name ;


# Q.10 Find the number and id of products sold in decreasing order of products sold 
#(display product id, no_of_products sold)
SELECT PROD_ID, SUM(ORDER_QUANTITY) "TOTAL_PROD_SOLD" FROM MARKET_FACT
GROUP BY PROD_ID
ORDER BY ORDER_QUANTITY DESC;

SELECT prod_id , COUNT(prod_id) AS no_of_products_sold FROM MARKET_FACT GROUP BY Prod_id ORDER BY COUNT(prod_id) DESC;


# Q.11 Display product Id and product sub category whose produt category belongs to 
#Furniture and Technlogy. The result should contain columns product id, product sub category.
SELECT prod_id, product_sub_category FROM PROD_DIMEN
WHERE PRODUCT_CATEGORY = "TECHNOLOGY" OR PRODUCT_CATEGORY = "FURNITURE";
SELECT prod_id 'product id', 
product_sub_category AS 'product sub category'
FROM PROD_DIMEN
WHERE PRODUCT_CATEGORY = "TECHNOLOGY" OR PRODUCT_CATEGORY = "FURNITURE";

select Prod_id, Product_Sub_Category from prod_dimen 
where Product_Category in ('FURNITURE','TECHNOLOGY');

# Q.12  Display the product categories in descending order of profits (display the product 
#category wise profits i.e. product_category, profits)?
SELECT PROD.PRODUCT_CATEGORY, MARKET.PROFIT
FROM PROD_DIMEN AS PROD JOIN MARKET_FACT AS MARKET
GROUP BY PRODUCT_CATEGORY
ORDER BY PROFIT DESC;
USE SUPERSTORE;

SELECT p.Product_Category, COUNT(m.Profit) AS profits  FROM market_fact m
JOIN prod_dimen p ON p.Prod_id=m.Prod_id
GROUP BY p.Product_Category ORDER BY COUNT(m.Profit) DESC;


# Q.13 Display the product category, product sub-category and the profit within each 
#subcategory in three columns. 
SELECT PROD.PRODUCT_CATEGORY, PROD.PRODUCT_SUB_CATEGORY, COUNT(MARKET.PROFIT) AS PROFIT
FROM MARKET_FACT AS MARKET 
JOIN PROD_DIMEN AS PROD ON PROD.PROD_ID = MARKET.PROD_ID
GROUP BY PROD.PRODUCT_SUB_CATEGORY;


select p.Product_Category , p.Product_Sub_Category, count(m.Profit) as profit  from market_fact m
join prod_dimen p on p.Prod_id=m.Prod_id
GROUP BY p.Product_Sub_Category;

select p.Product_Category as "Product Category", p.Product_Sub_Category as "Product Sub Category",
		round(sum(m.Profit), 2) as "Total Profits"
from market_fact m 
        join prod_dimen p on m.Prod_id = p.Prod_id
group by p.Product_Sub_Category
Order by p.Product_Category;

# Q.14  Display the order date, order quantity and the sales for the order.
SELECT ord.Order_date as "Order Date", mark.Order_Quantity as "Order Quantity", mark.sales "Sales"
 FROM superstore.market_fact as mark join superstore.orders_dimen as ord 
 ON ord.Ord_id = mark.Ord_id;
 
 select o.Order_Date, m.Order_Quantity, Sales as sales from market_fact m
join orders_dimen o on o.Ord_id=m.Ord_id;

 use superstore;

# Q.15 Display the names of the customers whose name contains the 
# i) Second letter as ‘R’
SELECT CUSTOMER_NAME FROM CUST_DIMEN
WHERE CUSTOMER_NAME LIKE "_R%";

# ii)) Fourth letter as ‘D’
SELECT CUSTOMER_NAME FROM CUST_DIMEN
WHERE CUSTOMER_NAME LIKE "___D%"; 

USE SUPERSTORE;
# Q.16 Write a SQL query to make a list with Cust_Id, Sales, Customer Name and 
#their region where sales are between 1000 and 5000.
SELECT C.CUST_ID "Cust ID", ROUND(MARK.SALES) "Sales", 
C.CUSTOMER_NAME "Customer Name", C.REGION "Region"
FROM CUST_DIMEN AS C JOIN MARKET_FACT AS MARK
WHERE SALES BETWEEN 1000 AND 5000;

select c.Cust_id, round(m.Sales), c.customer_name, c.Region from market_fact m
join cust_dimen c on c.Cust_id=m.Cust_id where round(m.sales) between 1000 and 5000;


# Q.17 Write a SQL query to find the 3rd highest sales
SELECT SALES FROM MARKET_FACT
ORDER BY SALES DESC;

SELECT MIN(sales) AS "3rd highest sales" 
FROM (SELECT ROUND(SUM(Sales)) AS sales FROM market_fact GROUP BY Cust_id ORDER BY SUM(Sales) DESC LIMIT 3) AS Tab1;


# Q.18 Where is the least profitable product subcategory shipped the most? For the least 
#profitable product sub-category, display the region-wise no_of_shipments and the
#profit made in each region in decreasing order of profits (i.e. region, 
#no_of_shipments, profit_in_each_region)
# → Note: You can hardcode the name of the least profitable product subcategory
SELECT * FROM SHIPPING_DIMEN JOIN CUST_DIMEN JOIN Market_fact;
use superstore;
#SELECT C.REGION, 
SELECT COUNT(ORDER_ID) FROM SHIPPING_DIMEN
WHERE SHIP_MODE = "REGULAR AIR";

SELECT M.PROFIT, C.REGION 
FROM MARKET_FACT AS M JOIN CUST_DIMEN AS C
GROUP BY C.REGION;

SELECT 
C.REGION, COUNT(DISTINCT S.SHIP_ID) AS no_of_shipments, sum(m.profit) as profit_in_each_region
from
Market_fact as m INNER JOIN CUST_dimen as c ON m.cust_id = c.cust_id
INNER JOIN shipping_dimen s ON m.ship_id = s.ship_id
INNER JOIN prod_dimen as p ON m.prod_id = p.prod_id
WHERE 
p.product_sub_category in
(SELECT p.product_sub_category 
FROM market_fact m INNER JOIN prod_dimen p ON m.prod_id = p.prod_id
GROUP BY P.PRODUCT_SUB_CATEGORY 
HAVING SUM(M.PROFIT)<=ALL 
(
SELECT SUM(M.PROFIT ) AS PROFITS 
FROM MARKET_FACT M INNER JOIN PROD_DIMEN P ON 
M.PROD_ID = P.PROD_ID
GROUP BY (P.PRODUCT_SUB_CATEGORY)
)
)
group by C.REGION
ORDER BY PROFIT_IN_EACH_REGION DESC;

SELECT * FROM MARKET_FACT;



SELECT c.Region, COUNT(s.Ship_id) AS no_of_shipment, ROUND(SUM(m.Profit)) AS profit FROM market_fact  m
JOIN cust_dimen c ON c.Cust_id=m.Cust_id
JOIN prod_dimen p ON p.Prod_id= m.Prod_id
JOIN shipping_dimen s ON s.Ship_id = m.Ship_id
WHERE p.Product_Sub_Category='TABLES' GROUP BY c.Region ORDER BY ROUND(SUM(m.Profit)) DESC;

SELECT DISTINCT COUNT(ORDER_ID) FROM ORDERS_DIMEN;

SELECT DISTINCT COUNT(ORDER_ID) FROM SHIPPING_DIMEN;
#ORDER BY SHIP_ID;
SELECT * FROM SHIPPING_DIMEN;