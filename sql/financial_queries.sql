-- To know the total revenue, expense, and profit for each business every month

SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    Business_Name,
   ROUND (SUM(Income), 2) AS Total_Revenue,
   ROUND (SUM(Expense), 2) AS Total_Expense,
   ROUND (SUM(Income - Expense), 2) AS Total_Profit
FROM financial_insight_data
GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
ORDER BY Month, Business_Name;

-- TO know the month and business with highest profit and best profit margin

SELECT TOP 1
    FORMAT(Date, 'yyyy-MM') AS Month,
    Business_Name,
    SUM(Net_Profit) AS TotalProfit,
   ROUND (SUM(Net_Profit) * 100.0 / SUM(Income), 2) AS ProfitMargin
FROM financial_insight_data
GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
ORDER BY TotalProfit DESC;

 --Trend Analysis
--To know the Revenue and profit trend month-by-month for each business
  
  SELECT
    FORMAT(Date, 'yyyy-MM') AS Month,
    Business_Name,
    SUM(Income) AS TotalRevenue,
    SUM(Net_Profit) AS TotalProfit
FROM  financial_insight_data
GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
ORDER BY Month, Business_Name;

--To know if there's growth or decline pattern across the 6 month?

WITH MonthlyProfit AS (
    SELECT
        FORMAT(Date, 'yyyy-MM') AS Month,
        Business_Name,
        SUM(Net_Profit) AS Profit
    FROM financial_insight_data
    GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
)

SELECT 
    Business_Name,
    Month,
    Profit,
    Profit - LAG(Profit) OVER (PARTITION BY Business_Name ORDER BY Month) AS MoM_Change
FROM MonthlyProfit;

--Expense Breakdown
-- To know the top expense categories for each business?
SELECT
    Business_Name,
    Expense_Category,
    SUM(Expense) AS Total_Expense
FROM financial_insight_data
GROUP BY Business_Name, Expense_Category
ORDER BY Business_Name, Total_Expense DESC;

--To know the percentage of revenue each expense category represent (Cost-to-Income Ratio)

SELECT
    Business_Name,
    Expense_Category,
    SUM(Expense) AS TotalExpense,
    SUM(Income) AS TotalRevenue,
    ROUND (SUM(Expense) * 100.0 / SUM(Income), 2) AS ExpenseToRevenuePercent
FROM financial_insight_data
GROUP BY Business_Name, Expense_Category
ORDER BY Business_Name, ExpenseToRevenuePercent DESC;

-- Business Comparison
-- To know Which business contributes the most to total profit overall

SELECT
    Business_Name,
    SUM(Net_Profit) AS TotalProfit,
    ROUND (SUM(Net_Profit) * 100.0 / (SELECT SUM(Net_Profit) 
	                              FROM financial_insight_data), 2) AS ProfitContributionPercent
FROM financial_insight_data
GROUP BY Business_Name
ORDER BY TotalProfit DESC;

-- To know Which business is more efficient (higher average profit margin)
SELECT
    Business_Name,
    SUM(Net_Profit) * 100.0 / SUM(Income) AS AvgProfitMargin
FROM financial_insight_data
GROUP BY Business_Name
ORDER BY AvgProfitMargin DESC;
