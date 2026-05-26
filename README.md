# Power BI Analytics — CodeAlpha Internship (Ammar Abdelkabir AbdelQader)

![Power BI](https://img.shields.io/badge/Power%20BI-Desktop-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-Calculations-0078D4?style=for-the-badge)
![Power Query](https://img.shields.io/badge/Power%20Query-ETL-107C41?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)

> End-to-end Business Intelligence dashboards developed during the **Power BI Desktop Development Internship** at [CodeAlpha](https://www.codealpha.tech).

---

##  Repository Structure

```
CodeAlpha_Power_BI_Internship/
│
├── README.md
├── .gitignore
│
├── Task 1 - Financial Health/
│   ├── Data/
│   │   └── Financial_Raw_Data.csv        ← 100+ rows of SME ledger data
│   ├── Report/
│   │   └── Financial_Health.pbix         ← Power BI report file
│   └── Screenshots/                      ← Dashboard preview images
│
├── Task 2 - HR Analytics/
│   ├── Data/
│   │   └── HR_Analytics_Data.csv         ← 30 employee records with full HR profile
│   ├── Report/
│   │   └── HR_Workforce_Analytics.pbix
│   └── Screenshots/
│
└── Task 3 - Real Estate Trends/
    ├── Data/
    │   └── Real_Estate_Market_Data.csv   ← 30 property listings across Egypt
    ├── Report/
    │   └── Real_Estate_Trends.pbix
    └── Screenshots/
```

---

##  Task 1 — Financial Health Dashboard

### Objective
Convert raw SME ledger data into an executive-level financial intelligence dashboard that tracks revenue streams, cost structures, and profitability margins over time.

### Dataset Overview
| Field | Description |
|-------|-------------|
| Date | Transaction date |
| Category | Revenue / COGS / Operating Expenses |
| Sub_Category | Detailed breakdown (Product Sales, Consulting, etc.) |
| Account | Specific ledger account |
| Amount | Transaction value in USD |
| Type | Credit or Debit |
| Scenario | Actual (Jan–Jun 2025) vs Budget (Jul–Dec 2025) |

**Data Range:** January 2025 – December 2025 | **Rows:** 100+

### DAX Measures

```dax
-- Calendar Table
Calendar = CALENDAR(MIN('Financial_Raw_Data'[Date]), MAX('Financial_Raw_Data'[Date]))
Month = FORMAT('Calendar'[Date], "YYYY-MM")

-- Core Financial KPIs
Total Revenue = 
    CALCULATE(SUM(Financial_Raw_Data[Amount]), Financial_Raw_Data[Category] = "Revenue")

Total COGS = 
    CALCULATE(SUM(Financial_Raw_Data[Amount]), Financial_Raw_Data[Category] = "COGS")

Total OpEx = 
    CALCULATE(SUM(Financial_Raw_Data[Amount]), Financial_Raw_Data[Category] = "Operating Expenses")

Gross Profit = [Total Revenue] - [Total COGS]

Net Profit = [Gross Profit] - [Total OpEx]

Net Profit Margin % = DIVIDE([Net Profit], [Total Revenue], 0)

Budget vs Actual Variance = 
    CALCULATE([Total Revenue], Financial_Raw_Data[Scenario] = "Actual") -
    CALCULATE([Total Revenue], Financial_Raw_Data[Scenario] = "Budget")
```

### Visualizations Built
| Visual | Purpose |
|--------|---------|
| KPI Cards (3) | Total Revenue, Net Profit, Net Profit Margin % |
| Line & Clustered Column Chart | Monthly Revenue vs OpEx with Margin trend line |
| Matrix (Income Statement) | Category → Sub_Category by Scenario (Actual vs Budget) |
| Slicer | Filter by Scenario, Category, Month |
| Area Chart | Revenue growth trajectory |

---

##  Task 2 — Human Resources Analytics Dashboard

### Objective
Equip HR leadership with a unified view of workforce health — tracking attrition risk, satisfaction-performance correlation, and recruitment cost forecasting.

### Dataset Overview
| Field | Description |
|-------|-------------|
| EmployeeID | Unique identifier |
| Department | Engineering / HR / Sales / Marketing / Finance / Operations |
| Role | Specific job title |
| HireDate / ExitDate | Employment period |
| Status | Active or Resigned |
| PerformanceRating | 1–5 score |
| SatisfactionScore | 1–5 score |
| MonthlySalary | In USD |
| HiringCost | Recruitment spend |
| Gender, Age, YearsExperience | Demographics |
| TrainingHours | Annual training investment |

**Records:** 30 employees | **Departments:** 6

### DAX Measures

```dax
Total Employees = 
    CALCULATE(COUNT(HR_Analytics_Data[EmployeeID]), HR_Analytics_Data[Status] = "Active")

Resigned Employees = 
    CALCULATE(COUNT(HR_Analytics_Data[EmployeeID]), HR_Analytics_Data[Status] = "Resigned")

Turnover Rate % = DIVIDE([Resigned Employees], COUNT(HR_Analytics_Data[EmployeeID]), 0)

Avg Satisfaction = AVERAGE(HR_Analytics_Data[SatisfactionScore])

Avg Performance = AVERAGE(HR_Analytics_Data[PerformanceRating])

Total Recruitment Cost = SUM(HR_Analytics_Data[HiringCost])

Avg Salary by Department = AVERAGE(HR_Analytics_Data[MonthlySalary])

Avg Tenure Days = 
    AVERAGEX(
        FILTER(HR_Analytics_Data, HR_Analytics_Data[Status] = "Active"),
        DATEDIFF(HR_Analytics_Data[HireDate], TODAY(), DAY)
    )
```

### Visualizations Built
| Visual | Purpose |
|--------|---------|
| KPI Cards (4) | Headcount, Turnover %, Avg Satisfaction, Total Hiring Cost |
| Horizontal Bar Chart | Headcount by Department |
| Scatter Plot | Satisfaction vs Performance (colored by Department) |
| Line Chart + Forecast | Recruitment Cost trend with AI-powered forecast |
| Donut Chart | Active vs Resigned split |
| Table | Employee detail view with conditional formatting |
| Slicers | Department, Status, Gender filters |

---

##  Task 3 — Real Estate Market Trends Dashboard

### Objective
Aggregate geographic property data, pricing metrics, and market conditions to identify investment hotspots and yield opportunities across Egyptian real estate markets.

### Dataset Overview
| Field | Description |
|-------|-------------|
| PropertyID | Unique property reference |
| City / Neighborhood | Location hierarchy |
| Latitude / Longitude | For map visualizations |
| PropertyType | Apartment / Villa / Townhouse / Chalet / Commercial |
| Bedrooms / SizeSqM | Property characteristics |
| Price / PricePerSqM | Valuation metrics |
| AnnualRentalYield | Investment return % |
| MonthlyRent | Rental income |
| DemandScore | 0–100 market demand indicator |
| SupplyCount | Available units in neighborhood |
| EconomicIndicator | Stable / Growing / Booming |
| DaysonMarket | Liquidity indicator |

**Properties:** 30 listings | **Cities:** Cairo, Alexandria, Giza

### DAX Measures

```dax
Average Price = AVERAGE(Real_Estate_Market_Data[Price])

Average Price Per SqM = AVERAGE(Real_Estate_Market_Data[PricePerSqM])

Average Yield % = AVERAGE(Real_Estate_Market_Data[AnnualRentalYield])

Total Available Properties = SUM(Real_Estate_Market_Data[SupplyCount])

Avg Demand Score = AVERAGE(Real_Estate_Market_Data[DemandScore])

Avg Days on Market = AVERAGE(Real_Estate_Market_Data[DaysonMarket])

High Yield Properties = 
    CALCULATE(
        COUNT(Real_Estate_Market_Data[PropertyID]),
        Real_Estate_Market_Data[AnnualRentalYield] >= 0.075
    )

Investment Score = 
    ([Avg Demand Score] * 0.4) + 
    ([Average Yield %] * 1000 * 0.4) + 
    ((1 / [Avg Days on Market]) * 1000 * 0.2)
```

### Visualizations Built
| Visual | Purpose |
|--------|---------|
| KPI Cards (4) | Avg Price, Avg Yield %, Total Properties, Avg Demand Score |
| Bubble Map | Properties plotted by lat/long, bubble size = Demand Score |
| Heat Map | Density overlay for market hotspot identification |
| Clustered Column Chart | Avg Price + Avg Yield by Neighborhood |
| Donut Chart | Property type distribution |
| Scatter Plot | Price vs Rental Yield by City |
| Slicers | City, PropertyType, EconomicIndicator filters |

---

##  Tools & Technologies

| Tool | Usage |
|------|-------|
| **Power BI Desktop** | Dashboard design and development |
| **Power Query (M Language)** | Data transformation and ETL |
| **DAX** | Calculated measures, KPIs, and tables |
| **Power BI Service** | Publishing and sharing |
| **GitHub** | Version control and portfolio hosting |

---

##  How to Run the Dashboards

1. **Install Power BI Desktop** — Download from [powerbi.microsoft.com](https://powerbi.microsoft.com/)
2. **Clone this repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/CodeAlpha_Power_BI_Internship.git
   ```
3. **Open any `.pbix` file** from the `Report/` subdirectory in Power BI Desktop
4. If prompted, update the data source path to point to the `Data/` folder in the same task directory
5. Click **Refresh** to reload data and recalculate all measures

---
