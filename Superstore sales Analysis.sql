-- First we have to change the order date and ship date to date format since it was in text format

UPDATE superstore
SET `order date` = STR_TO_DATE(`order date`, '%m/%d/%Y')
WHERE `order date` IS NOT NULL;

ALTER TABLE superstore
MODIFY COLUMN `order date` DATE;

UPDATE superstore
SET `ship date` = STR_TO_DATE(`ship date`, '%m/%d/%Y')
WHERE `ship date` IS NOT NULL;

ALTER TABLE superstore
MODIFY COLUMN `ship date` DATE;

-- 1)What are the total sales and total profit for each year

select year(`order date`) as year, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit
from superstore
group by year
order by year
;


-- 2) How to get the total sales and profit per quarter?\

select year(`order date`) as year,
quarter(`order date`) as quarter,
sum(sales) as Total_sales,
sum(profit) as total_sales
from superstore
group by year, quarter
order by year;

-- 3) Which region generates the highest profit?

select region, sum(profit) as total_profit,
sum(sales) as total_sales
from superstore
group by region
order by total_profit desc
limit 1;

-- 4) What state and city brings in highest sales and profits?

select state, sum(profit) as total_profit,
sum(sales) as total_sales,
round((sum(profit)/sum(sales)) * 100,2) as profit_margin
from superstore
group by state
order by total_profit desc
;

select city, sum(profit) as total_profit,
sum(sales) as total_sales,
round((sum(profit)/sum(sales)) * 100,2) as profit_margin
from superstore
group by city
order by total_profit desc
;

-- 5. The relationship between discount and sales and the total discount per categor

 SELECT Discount, AVG(Sales) AS Avg_Sales
 FROM superstore
 GROUP BY Discount
 ORDER BY Discount;
 
 -- Let’s observe the total discount per product category:
 
 SELECT category, SUM(discount) AS total_discount
 FROM superstore
 GROUP BY category
 ORDER BY total_discount DESC;
 
 
 SELECT category, `sub-category`, SUM(discount) AS total_discount
 FROM superstore
 GROUP BY category, `sub-category`
 ORDER BY total_discount DESC;
 
 -- 6. What category generates the highest sales and profits in each region and state ?
 
  SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
 FROM superstore
 GROUP BY category
 ORDER BY total_profit DESC;
 
  SELECT region, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY region, category
 ORDER BY total_profit DESC;
 
 -- Now let’s see the highest total sales and total profits per Category in each state
 
  SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY state, category
 ORDER BY total_profit DESC;
 
 -- Let’s check the least profitable ones:
 
 SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY state, category
 ORDER BY total_profit ASC;
 
 -- 7. What subcategory generates the highest sales and profits in each region and state ?
 
  SELECT `sub-category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_marg
 FROM superstore
 GROUP BY `sub-category`
 ORDER BY total_profit DESC;
 
 --  Now let’s see the highest total sales and total profits per subcategory in each region:
 
 SELECT region, `sub-category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY region, `sub-category`
 ORDER BY total_profit DESC;
 
  --  Now let’s see the highest total sales and total profits per subcategory in each state:

 SELECT state, `sub-category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY state, `sub-category`
 ORDER BY total_profit DESC;
 
 --  8. What are the names of the products that are the most and least profitable to us?

 SELECT `product name`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY `product name`
 ORDER BY total_profit DESC;
 
 -- Least profitable ones
 
  SELECT `product name`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY `product name`
 ORDER BY total_profit ASC;
 
 -- 9. What segment makes the most of our profits and sales ?
 
 SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit
 FROM superstore
 GROUP BY segment
 ORDER BY total_profit DESC;
 
 --  10. How many customers do we have (unique customer IDs) in total and how much per region and state?

SELECT region, COUNT(DISTINCT `customer id`) AS total_customers
 FROM superstore
 group by region
 order by total_customers desc;

SELECT state, COUNT(DISTINCT `customer id`) AS total_customers
 FROM superstore
 group by state
 order by total_customers desc;
 
 -- 11. Customer rewards program, Find customer with highest spends
 
  SELECT `customer id`, 
SUM(sales) AS total_sales,
 SUM(profit) AS total_profit
 FROM superstore
 GROUP BY `customer id`
 ORDER BY total_sales DESC
 LIMIT 15;
 
 -- 12. Find Average shipping time per class and in total
 
 SELECT ROUND(AVG(`ship date` - `order date`),1) AS avg_shipping_time
 FROM superstore;
 
 SELECT `ship mode`,ROUND(AVG(`ship date` - `order date`),1) AS avg_shipping_time
 FROM superstore
 GROUP BY `ship mode`
 ORDER BY avg_shipping_time;
 
