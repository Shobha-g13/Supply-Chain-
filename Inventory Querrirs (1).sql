create database Inventory;
use Inventory;
## Product Wise Sales
SELECT 
    p.[Product Name],
    COUNT(s.[Order Number]) AS Total_Orders,
    SUM(p.[Price]) AS Total_Sales
FROM F_SALES s
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY p.[Product Name]
ORDER BY Total_Sales DESC;

## Sales Growth (Month-over-Month)
SELECT 
    FORMAT(s.[Date], 'yyyy-MM') AS Month,
    SUM(p.[Price]) AS Monthly_Sales,
    LAG(SUM(p.[Price])) OVER (ORDER BY FORMAT(s.[Date], 'yyyy-MM')) AS Prev_Month_Sales,
    (SUM(p.[Price]) - LAG(SUM(p.[Price])) OVER (ORDER BY FORMAT(s.[Date], 'yyyy-MM'))) / 
     NULLIF(LAG(SUM(p.[Price])) OVER (ORDER BY FORMAT(s.[Date], 'yyyy-MM')), 0) * 100 AS Growth_Percentage
FROM F_SALES s
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY FORMAT(s.[Date], 'yyyy-MM')
ORDER BY Month;

## Daily Sales Trend
SELECT 
    s.[Date],
    SUM(p.[Price]) AS Daily_Sales
FROM F_SALES s
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY s.[Date]
ORDER BY s.[Date];

## State Wise Sales
SELECT 
    st.[Store State],
    SUM(p.[Price]) AS Total_Sales
FROM F_SALES s
JOIN D_STORE st ON s.[Store Key] = st.[Store Key]
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY st.[Store State]
ORDER BY Total_Sales DESC;

## Top 5 Store Wise Sales
SELECT TOP 5
    st.[Store Name],
    SUM(p.[Price]) AS Total_Sales
FROM F_SALES s
JOIN D_STORE st ON s.[Store Key] = st.[Store Key]
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY st.[Store Name]
ORDER BY Total_Sales DESC;

## Region Wise Sales
SELECT 
    st.[Store Region],
    SUM(p.[Price]) AS Total_Sales
FROM F_SALES s
JOIN D_STORE st ON s.[Store Key] = st.[Store Key]
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY st.[Store Region]
ORDER BY Total_Sales DESC;

## Total Inventory
SELECT 
    SUM([Quantity on Hand]) AS Total_Inventory_Units
FROM F_INVENTORY_ADJUSTED;

## Inventory Value
SELECT 
    SUM([Quantity on Hand] * [Cost Amount]) AS Total_Inventory_Value
FROM F_INVENTORY_ADJUSTED;

## Purchase Method Wise Sales
SELECT 
    s.[Purchase Method],
    SUM(p.[Price]) AS Total_Sales,
    COUNT(s.[Order Number]) AS Number_of_Orders
FROM F_SALES s
JOIN D_PRODUCT p ON s.[Product Key] = p.[Product Key]
GROUP BY s.[Purchase Method]
ORDER BY Total_Sales DESC; 