# Financial Intelligence Dashboard  
**SQL + Excel Case Study for Small Business Profitability Analysis**

**Short Description:**  
A data-driven financial analysis project designed to help small business founders understand their **true profitability**, not just revenue. Using **SQL for data transformation** and **Excel for dashboard modelling**, this solution reveals hidden financial trends, cost efficiency issues, and business-unit performance.

---

## Table of Contents 
1. [Project Overview](#project-overview)  
2. [Problem Statement](#problem-statement)  
3. [Dataset Summary](#dataset-summary)  
4. [Key SQL Queries](#key-sql-queries-short-versions)  
5. [Dashboard Features](#dashboard-features)  
6. [Dashboard Preview](#dashboard-preview)  
7. [Key Insights](#key-insights-summary)  
8. [Tools Used](#tools-used)  
9. [Skills Demonstrated](#skills-demonstrated)  
10. [Business Impact](#business-impact)
11. [Conclusion](#conclusion) 
12. [Project Structure](#project-structure-repo-layout)  
13. [How to Use the Project](#how-to-use-the-project)

---

## Project Overview
Small business founders often track **revenue**, but not **profit margin**, **cost efficiency**, or **expense structure**.  
This dashboard analyzes 6 months of operational data (May–Oct 2025) for two businesses:

- **Malvin Adire Stores**  
- **Skincare Studio**

The result is a **decision-support tool** that uncovers profitability drivers and operational inefficiencies.

---

## Problem Statement
Founders frequently misjudge profitability because they:

- Focus on sales instead of margins  
- Ignore cost-to-income ratio  
- Lack financial reporting structure  
- Do not compare business units efficiently  

This project addresses these blind spots with analytics.

---

## Dataset Summary
Custom-built, realistic dataset covering **May–October 2025**:

| Column           | Description                          |
|------------------|--------------------------------------|
| Date             | Monthly transaction date             |
| Business_Name    | Adire Stores / Skincare Studio       |
| Income           | Monthly revenue                      |
| Expense          | Monthly operating cost               |
| Expense_Category | Marketing, Rent, Logistics, Staff    |
| Net_Profit       | Income - Expense                     |
| Channel          | Online / Offline                     |

Dataset includes natural fluctuations for meaningful insights.

---

## Key SQL Queries (Short Versions)
SQL was used to perform data cleaning, aggregation, business performance analysis, and financial calculations.  
Below are the **Top 5 queries** included in the README.  
The *full SQL script* is stored in:  [View financial_queries.sql](./sql/financial_queries.sql)


### 1. Monthly Revenue, Expense & Profit
```sql
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    Business_Name,
    ROUND(SUM(Income), 2) AS Total_Revenue,
    ROUND(SUM(Expense), 2) AS Total_Expense,
    ROUND(SUM(Income - Expense), 2) AS Total_Profit
FROM financial_insight_data
GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
ORDER BY Month, Business_Name;
```

### 2. Highest Profit Month & Best Profit Margin
```sql
SELECT TOP 1
    FORMAT(Date, 'yyyy-MM') AS Month,
    Business_Name,
    SUM(Net_Profit) AS TotalProfit,
    ROUND(SUM(Net_Profit) * 100.0 / SUM(Income), 2) AS ProfitMargin
FROM financial_insight_data
GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
ORDER BY TotalProfit DESC;
```

### 3. Trend Analysis – Month-by-Month Revenue & Profit
```sql
SELECT
    FORMAT(Date, 'yyyy-MM') AS Month,
    Business_Name,
    SUM(Income) AS TotalRevenue,
    SUM(Net_Profit) AS TotalProfit
FROM financial_insight_data
GROUP BY FORMAT(Date, 'yyyy-MM'), Business_Name
ORDER BY Month, Business_Name;
```

### 4. Month-over-Month Profit Change (MoM)
```sql
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
```

### 5. Expense Breakdown by Category
```sql
SELECT
    Business_Name,
    Expense_Category,
    SUM(Expense) AS Total_Expense
FROM financial_insight_data
GROUP BY Business_Name, Expense_Category
ORDER BY Business_Name, Total_Expense DESC;
```
---

## Dashboard Features
Excel dashboard includes:

- **KPI Cards:** Revenue, Expense, Profit, Profit Margin  
- **Trend Charts:** Revenue vs Expense, Monthly Profit  
- **Business Comparison:** Profitability, Revenue vs Cost  
- **Expense Breakdown:** Category-level analysis  
- **Scenario Simulator:**  
  - +10% expense increase  
  - –20% logistics cost  
  - +15% revenue growth  

Designed for **founder-friendly consulting insights**.

---

## Dashboard Preview
![Dashboard Preview](https://raw.githubusercontent.com/PreciousNwachukwu/financial-intelligence-dashboard/b65ae8256c1e921cda5f3d21ad44aeff75212bb8/dashboard.png)

---

## Key Insights (Summary)
- **Highest Revenue:** Skincare Studio – $372K  
- **Highest Profit:** Malvin Adire Stores – $184K  
- **Most Efficient (Margin):** Malvin Adire Stores – 52.9%  
- **Best Month:** May (Revenue: $99K, Profit: $47K)  

**Additional Insight:**  
Skincare Studio incurs higher operating costs ($212K vs $164K), compressing margins.

**Long Report:**  
[Download PDF](./Financial_Intelligence_Dashboard_Case_Study.pdf)

---

## Tools Used
- **SQL** — Transformation & financial metrics  
- **Excel** — Dashboard modeling & scenario analysis  

---

## Skills Demonstrated
- Advanced SQL querying  
- Excel dashboard design  
- Scenario modeling  
- Financial storytelling  
- Data validation & cleaning  
- Business analytics  

---

## Business Impact
This dashboard helps founders:

- Identify which business drives the most profit  
- Optimize expense allocation & reduce waste  
- Improve pricing strategies  
- Conduct monthly performance reviews  
- Predict margins using what-if analysis  

---

## Conclusion
This project demonstrates how small businesses can move beyond surface-level revenue tracking to make **profit-focused, data-driven decisions**.

By combining SQL-based financial analysis with an interactive Excel dashboard, the solution provides founders with:
- Clear visibility into profitability drivers
- Actionable cost control insights
- A repeatable framework for monthly financial reviews

The Financial Intelligence Dashboard mirrors real-world consulting workflows and highlights my ability to translate raw financial data into strategic business insights.

---

## Project Structure (Repo Layout)
```
financial-intelligence-dashboard/
├── README.md
├── data/
│   └── financial_insight_data.csv
├── sql/
│   └── financial_queries.sql
├── dashboard/
│   └── financial_dashboard.xlsx
└── documentation/
    └── Financial_Case_Study.pdf
```

---

## How to Use the Project
1. Review the README for business context and insights.
2. Download the Excel dashboard to explore KPIs and scenario simulations.
3. Open the SQL file to review financial analysis logic.
4. Read the full case study PDF for detailed explanations and visuals.


