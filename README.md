# Financial Intelligence Dashboard
**SQL + Excel · Small Business Profitability Analysis**

> Built for founders who track revenue but not profit. This dashboard revealed that **Malvin Adire Stores was 52.9% more margin-efficient than Skincare Studio** despite generating lower revenue, a finding that completely reframes how a founder should prioritise growth, pricing, and cost control.

📊 [View Dashboard Screenshot](#dashboard-preview) · 📄 [Download Full Case Study PDF](https://github.com/PreciousNwachukwu/financial-intelligence-dashboard/blob/main/Financial_Intelligence_Dashboard_Case_Study.pdf) · 🗂 [View SQL Queries](./sql/financial_queries.sql)

---

## Dashboard Preview

![Financial Intelligence Dashboard](https://raw.githubusercontent.com/PreciousNwachukwu/financial-intelligence-dashboard/b65ae8256c1e921cda5f3d21ad44aeff75212bb8/dashboard.png)

---

## The Business Problem

Small business founders routinely mistake high revenue for high profitability. This project addresses three blind spots that cost founders money every month:

- Tracking sales without tracking margins
- Ignoring which expense categories eat the most profit
- Having no structured way to compare performance across business units or time periods

Without this visibility, a founder can be growing revenue while quietly shrinking profit and not know it until it's a crisis.

---

## What This Dashboard Does

Covers **6 months of operational data (May–October 2025)** across two businesses:

- **Malvin Adire Stores** — fashion/textile retail
- **Skincare Studio** — beauty and skincare products

It answers five questions every founder should be asking every month:

1. Which business unit is actually more profitable, not just busier?
2. What does my cost-to-income ratio look like by expense category?
3. Which months are my strongest, and why?
4. Is my profit growing or shrinking month-over-month?
5. What happens to my margins if costs rise or revenue drops?

---

## Key Results

| Metric | Finding |
|---|---|
| Highest Revenue | Skincare Studio — $372K over 6 months |
| Highest Profit | Malvin Adire Stores — $184K over 6 months |
| Best Profit Margin | Malvin Adire Stores — **52.9%** |
| Worst Cost Burden | Skincare Studio — $212K in expenses vs $164K for Adire |
| Best Single Month | May — $99K revenue, $47K profit |

**The key insight:** Skincare Studio generates more revenue but loses more of it to operating costs. A founder chasing Skincare Studio's revenue numbers without fixing its cost structure is running in the wrong direction.

---

## Dataset

Custom-built, realistic dataset designed to reflect natural business fluctuations:

| Column | Description |
|---|---|
| Date | Monthly transaction date (May–Oct 2025) |
| Business_Name | Malvin Adire Stores / Skincare Studio |
| Income | Monthly revenue |
| Expense | Monthly operating cost |
| Expense_Category | Marketing · Rent · Logistics · Staff |
| Net_Profit | Income minus Expense |
| Channel | Online / Offline |

---

## SQL Analysis

All queries were written in **SQL Server**. Five analytical layers were built:

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

### 2. Best Profit Month & Highest Margin
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

### 3. Month-over-Month Profit Change (Window Function)
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

### 4. Expense Breakdown by Category
```sql
SELECT
    Business_Name,
    Expense_Category,
    SUM(Expense) AS Total_Expense
FROM financial_insight_data
GROUP BY Business_Name, Expense_Category
ORDER BY Business_Name, Total_Expense DESC;
```

### 5. Cost-to-Income Ratio by Category
```sql
SELECT
    Business_Name,
    Expense_Category,
    SUM(Expense) AS TotalExpense,
    SUM(Income) AS TotalRevenue,
    ROUND(SUM(Expense) * 100.0 / SUM(Income), 2) AS ExpenseToRevenuePercent
FROM financial_insight_data
GROUP BY Business_Name, Expense_Category
ORDER BY Business_Name, ExpenseToRevenuePercent DESC;
```

[📄 View full SQL script →](./sql/financial_queries.sql)

---

## Excel Dashboard Features

| Feature | Description |
|---|---|
| KPI Cards | Revenue · Expense · Profit · Profit Margin |
| Trend Charts | Revenue vs Expense · Monthly Profit over time |
| Business Comparison | Side-by-side profitability and cost efficiency |
| Expense Breakdown | Category-level cost analysis per business unit |
| Scenario Simulator | +10% expense · –20% logistics · +15% revenue growth |

---

## Strategic Recommendations

Based on this analysis, here is what the data actually recommends:

**For Malvin Adire Stores:** Protect and expand the margin. The 52.9% margin is exceptional for a product-based business. The priority is not chasing more revenue; it is scaling the product mix that sustains this margin while keeping operating costs flat.

**For Skincare Studio:** The problem is not revenue, it is cost structure. With $212K in operating expenses against $372K revenue, every growth decision must be tested against its margin impact first. The immediate action is auditing the Logistics and Marketing categories, which are the most compressible without touching revenue.

**For both businesses:** The May performance ($99K revenue, $47K profit) suggests a seasonal or promotional pattern worth replicating. Understanding what drove May and building it into Q1 planning, is worth more than any cost-cutting exercise.

---

## Tools Used

- **SQL Server** — Data transformation, aggregation, window functions
- **Microsoft Excel** — Dashboard modelling, scenario analysis, KPI visualisation

---

## Skills Demonstrated

- Advanced SQL: CTEs, window functions (LAG), subqueries, aggregations
- Financial analytics and profitability modelling
- Excel dashboard design with scenario simulation
- Business storytelling, translating data findings into founder-ready recommendations
- Dataset design and data validation

---

## Project Structure

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

## How to Use

1. Read this README for business context and key findings
2. Open `financial_dashboard.xlsx` to explore KPIs and run scenario simulations
3. Review `financial_queries.sql` to see the full analytical logic
4. Download the case study PDF for a detailed walkthrough with visuals

---

*Built by [Precious Nwachukwu](https://www.linkedin.com/in/precious-nwachukwu-873b432b7/) · Data Analyst · Abuja, Nigeria*
