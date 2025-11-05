use supply_chain;
show tables ;
select * from supply_chain;
 -- Total unit_price
select round(sum(unit_Price)/1000,2)
 from supply_chain;  


-- Total count of order id in this query
select count(distinct order_id)
from supply_chain;

-- Total Sales revenue
SELECT round(SUM(Unit_Price * Quantity)/1000,2 )AS Total_Sales_Revenue
FROM supply_chain;

-- Average Order Value
SELECT round(SUM(Unit_Price * Quantity)/1000,2) / COUNT(Order_ID) AS Average_Order_Value
FROM supply_chain;

  -- Orders by Region/Country/City
  SELECT Region, Country, City, COUNT(Order_ID) AS Total_Orders
FROM supply_chain
GROUP BY Region, Country, City
ORDER BY Total_Orders DESC;


-- 3. Procurement & Cost KPIs----

-- Procurement cost-------
select round( sum(procurement_cost)/1000,2)as procurementcost from supply_chain;
-- Transportation Cost -----
select round(sum(Transportation_Cost)/1000,2) as Transportationcost from supply_chain;

-- Total Supply Chain Cost -----

select round(sum(Total_Cost)/1000,2)as TotalSupplyChainCost from supply_chain;

-- Cost per Unit --

select sum(Total_cost)/sum(Quantity) as CostPerUnit from supply_chain;

-- 4. Logistics & Delivery KPIs ----

SELECT 
    (SUM(CASE WHEN Delivery_Status = 'On-Time' THEN 1 ELSE 0 END) * 100.0/ COUNT(*)) AS On_Time_Delivery_Percentage
FROM Supply_chain;
-- Average Delay ----
SELECT 
    round(AVG(Delay_Days))AS Average_Delay_Days
FROM Supply_chain;

-- order by ship mode ---
SELECT 
    Ship_Mode,
    COUNT(Order_ID) AS Total_Orders
FROM Supply_Chain
GROUP BY Ship_Mode
ORDER BY Total_Orders DESC;

-- 5.Demand and fullfill ment kpi ---
-- forcecast Accurucy ---
SELECT 
    (1 - (ABS(SUM(Forecast_Demand - Actual_Demand)) * 1.0 / SUM(Forecast_Demand))) * 100 AS Forecast_Accuracy_Percentage
FROM Supply_chain
WHERE Forecast_Demand > 0;

-- fill rate --
SELECT 
    AVG(Fill_Rate) * 100 AS Average_Fill_Rate_Percentage
FROM Supply_chain;

--  demand and actual forecaast --
SELECT 
    Order_Date,
    SUM(Forecast_Demand) AS Total_Forecast_Demand,
    SUM(Actual_Demand) AS Total_Actual_Sales
FROM Supply_Chain
GROUP BY Order_Date
ORDER BY Order_Date;

