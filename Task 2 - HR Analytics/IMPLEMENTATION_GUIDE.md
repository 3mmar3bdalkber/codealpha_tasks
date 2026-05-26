# Task 2 — Human Resources Analytics Dashboard

## Step-by-Step Implementation Guide

---

## Step 1: Load Data

1. **Home → Get Data → Text/CSV**
2. Select `Data/HR_Analytics_Data.csv`
3. Click **Transform Data**

---

## Step 2: Power Query Transformations

In Power Query Editor:

1. **HireDate** → Change Type → **Date**
2. **ExitDate** → Change Type → **Date**  
   > ⚠️ ExitDate will have null/empty values for Active employees — this is correct. Do NOT replace nulls.
3. **MonthlySalary, HiringCost, Age, YearsExperience, TrainingHours, PerformanceRating, SatisfactionScore** → Change Type → **Whole Number**
4. **Status, Department, Role, Gender** → Verify as **Text**

**Add a custom column for Tenure (in years):**
- Click **Add Column → Custom Column**
- Name: `TenureYears`
- Formula:
```
= if [ExitDate] = null 
  then Duration.Days(DateTime.LocalNow() - [HireDate]) / 365
  else Duration.Days([ExitDate] - [HireDate]) / 365
```

5. Click **Close & Apply**

---

## Step 3: Create All DAX Measures

```dax
Total Employees = 
    CALCULATE(
        COUNT(HR_Analytics_Data[EmployeeID]), 
        HR_Analytics_Data[Status] = "Active"
    )
```

```dax
Resigned Employees = 
    CALCULATE(
        COUNT(HR_Analytics_Data[EmployeeID]), 
        HR_Analytics_Data[Status] = "Resigned"
    )
```

```dax
Turnover Rate % = 
    DIVIDE([Resigned Employees], COUNT(HR_Analytics_Data[EmployeeID]), 0)
```

```dax
Avg Satisfaction = AVERAGE(HR_Analytics_Data[SatisfactionScore])
```

```dax
Avg Performance = AVERAGE(HR_Analytics_Data[PerformanceRating])
```

```dax
Total Recruitment Cost = SUM(HR_Analytics_Data[HiringCost])
```

```dax
Avg Monthly Salary = AVERAGE(HR_Analytics_Data[MonthlySalary])
```

```dax
Total Payroll = SUM(HR_Analytics_Data[MonthlySalary])
```

```dax
Avg Training Hours = AVERAGE(HR_Analytics_Data[TrainingHours])
```

```dax
High Performers = 
    CALCULATE(
        COUNT(HR_Analytics_Data[EmployeeID]),
        HR_Analytics_Data[PerformanceRating] >= 4,
        HR_Analytics_Data[Status] = "Active"
    )
```

```dax
Retention Rate % = 1 - [Turnover Rate %]
```

---

## Step 4: Build the Dashboard Page

### Page 1: "Workforce Overview"

**Row 1 — KPI Cards**
- Active Headcount: `Total Employees`
- Turnover Rate: `Turnover Rate %`
- Avg Satisfaction: `Avg Satisfaction`
- Total Hiring Cost: `Total Recruitment Cost`

**Row 2 — Left: Department Breakdown**
- Visual: **Clustered Bar Chart**
  - Y-Axis: `Department`
  - X-Axis: `Total Employees`
  - Tooltip: `Avg Monthly Salary`

**Row 2 — Right: Active vs Resigned**
- Visual: **Donut Chart**
  - Legend: `Status`
  - Values: Count of `EmployeeID`

---

### Page 2: "Satisfaction & Performance"

**Main Visual: Scatter Plot**
- X-Axis: `SatisfactionScore` (average)
- Y-Axis: `PerformanceRating` (average)
- Details: `Name`
- Legend: `Department`
- Size: `MonthlySalary`

> 💡 Insight: Look for the bottom-left quadrant (Low Satisfaction + Low Performance) = flight risk employees

**Supporting Visual: Matrix Table**
- Rows: `Department`
- Values: `Avg Satisfaction`, `Avg Performance`, `Turnover Rate %`
- Apply conditional formatting with color scales

---

### Page 3: "Recruitment & Forecast"

**Line Chart with Forecast**
- X-Axis: `HireDate` (Month granularity)
- Y-Axis: `Total Recruitment Cost`

**Enable Forecast:**
1. Click the chart
2. Go to **Analytics pane** (magnifying glass icon in Visualizations)
3. Expand **Forecast**
4. Set: Forecast Length = 6, Confidence Interval = 95%

**Slicers on all pages:**
- `Department` (multi-select)
- `Status` (Active / Resigned)
- `Gender`

---

## Step 5: Formatting Tips

- Use **conditional formatting** on tables: Green for high performance/satisfaction, Red for low
- Add **employee photo placeholders** using image URL column if desired
- Set **page tooltip** on the scatter plot to show employee name + salary on hover

---

## Step 6: Save

Save as: `Report/HR_Workforce_Analytics.pbix`
