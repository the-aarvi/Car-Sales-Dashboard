-- ========================================================
-- Create and Select Database
-- ========================================================
CREATE DATABASE Car_Sales_db;
USE Car_Sales_db;


-- ========================================================
-- Rename table for easier reference
-- ========================================================
RENAME TABLE cleaned_car_sales_dataset TO car_sales_table;


-- ========================================================
-- YTD Total Sales (in Millions) - 2023
-- ========================================================
SELECT 
    CONCAT(ROUND(SUM(Price) / 1000000, 2), 'M') AS Total_Sales
FROM Car_sales_table
WHERE YEAR(`Date`) = 2023;


-- ========================================================
-- MTD Total Sales (in Millions) - December 2023
-- ========================================================
SELECT 
    CONCAT(ROUND(SUM(Price) / 1000000, 2), 'M') AS MTD_Total_Sales_Millions
FROM Car_sales_table
WHERE YEAR(Date) = 2023
  AND MONTH(Date) = 12;


-- ========================================================
-- YTD Average Price (in Thousands) - 2023
-- ========================================================
SELECT 
    CONCAT(ROUND(AVG(Price) / 1000, 2),'k') AS YTD_Avg_Price
FROM Car_sales_table
WHERE YEAR(Date) = 2023;


-- ========================================================
-- MTD Average Price (in Thousands) - December 2023
-- ========================================================
SELECT 
    CONCAT(ROUND(AVG(Price) / 1000, 2), 'k') AS MTD_Avg_Price
FROM Car_sales_table
WHERE YEAR(Date) = 2023
  AND MONTH(Date) = 12;


-- ========================================================
-- YTD Cars Sold (in Thousands) - 2023
-- ========================================================
SELECT 
    CONCAT(ROUND(COUNT(Car_id) / 1000, 2), 'k') AS YTD_Cars_Sold
FROM Car_sales_table
WHERE YEAR(Date) = 2023;


-- ========================================================
-- MTD Cars Sold (in Thousands) - December 2023
-- ========================================================
SELECT 
    CONCAT(ROUND(COUNT(Car_id) / 1000, 2), 'k') AS MTD_Cars_Sold
FROM Car_sales_table
WHERE YEAR(Date) = 2023
  AND MONTH(Date) = 12;


-- ========================================================
-- Weekly Sales Trend (in Millions) - 2022
-- ========================================================
SELECT 
    WEEK(Date, 1)  AS Week,  
    CONCAT(ROUND(SUM(Price)/ 1000000, 2), 'M') AS Weekly_Sales
FROM Car_sales_table
WHERE YEAR(Date) = 2022
GROUP BY Week
ORDER BY Week;


-- ========================================================
-- Most Selling Day of the Week (in Millions) - 2022
-- ========================================================
SELECT 
    DAYNAME(Date) AS Day_Of_Week,
    CONCAT(ROUND(SUM(Price) / 1000000, 2), 'M') AS Total_Sales_Millions
FROM Car_sales_table
WHERE YEAR(Date) = 2022
GROUP BY Day_Of_Week
ORDER BY SUM(Price) DESC
LIMIT 1; 


-- ========================================================
-- YTD Total Sales by Body Style (in Millions) - 2022
-- ========================================================
SELECT 
    Body_Style,
    CONCAT(ROUND(SUM(Price)/ 1000000, 2), 'M') AS Total_Sales
FROM Car_sales_table
WHERE YEAR(Date) = 2022
GROUP BY Body_Style
ORDER BY Total_Sales DESC; 


-- ========================================================
-- YTD Total Sales by Color (in Millions) - 2022
-- ========================================================
SELECT 
    Color,
    CONCAT(ROUND(SUM(Price)/ 1000000, 2), 'M') AS Total_Sales
FROM Car_sales_table
WHERE YEAR(Date) = 2022
GROUP BY Color
ORDER BY Total_Sales DESC;


-- ========================================================
-- YTD Cars Sold & Sales by Dealer Region (in Millions) - 2022
-- ========================================================
SELECT 
    Dealer_Region,
    COUNT(Car_id) AS Cars_Sold,
    CONCAT(ROUND(SUM(Price)/ 1000000, 2), 'M') AS Total_Sales
FROM Car_sales_table
WHERE YEAR(Date) = 2022
GROUP BY Dealer_Region
ORDER BY Cars_Sold DESC;


-- ========================================================
-- Company-wise YTD Sales Summary (2022)
-- Includes Avg Price, Cars Sold, Total Sales & % Contribution
-- ========================================================
SELECT 
    Company,
    ROUND(AVG(Price), 2) AS YTD_Avg_Price,
    COUNT(Car_id) AS YTD_Cars_Sold,
    SUM(Price) AS YTD_Total_Sales,
    100.0 * SUM(Price) / 
       (SELECT SUM(Price) FROM Car_sales_table WHERE YEAR(Date) = 2022) 
       AS Percent_YTD_Total_Sales
FROM Car_sales_table
WHERE YEAR(Date) = 2022
GROUP BY Company
ORDER BY YTD_Total_Sales DESC;
