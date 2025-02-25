SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [pizza].[dbo].[pizza_sales]

--total revenue 
SELECT SUM(total_price ) AS revenue
FROM pizza_sales;

--Average Order Value
SELECT SUM(total_price )  / count (DISTINCT order_id)as Avg_order_Value  
from pizza_sales ;

--Total Pizzas Sold
select sum(quantity ) as Total_pizza_sold from pizza_sales;

-- Total Orders
select count (distinct order_id)as Total_Orders from pizza_sales;

--Average Pizzas Per Order
SELECT CAST(SUM(CAST(quantity AS DECIMAL(10,2))) / 
            COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;

--Daily Trend for Total Orders

SELECT DATENAME(DW,order_date)as day_order, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW,order_date);


--monthely Trend for Total Orders
SELECT DATENAME(MONTH,order_date)AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date);

-- % of Sales by Pizza Category
SELECT pizza_category, 
       ROUND(SUM(total_price), 2) AS total_revenue,
       ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- % of Sales by Pizza size
select pizza_size,
      round(SUM(total_price),2)as total_revenue,
	  ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS PCT
FROM pizza_sales
GROUP BY pizza_size
order by pizza_size;

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Top 5 Pizzas by Revenue
select top 5 pizza_name,round(SUM(total_price),2) as total_revenue
FROM pizza_sales
GROUP BY pizza_name
order by pizza_name desc;

--Bottom 5 Pizzas by Revenue
select top 5 pizza_name,SUM(total_price)as total_revenue
FROM pizza_sales
GROUP BY pizza_name
order by pizza_name asc;

--Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold desc

--Bottom 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold asc;


--Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--Bottom Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders 
