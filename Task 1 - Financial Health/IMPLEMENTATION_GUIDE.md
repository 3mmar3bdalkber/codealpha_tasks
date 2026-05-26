# Task 1 — Financial Health Dashboard

## Step-by-Step Implementation Guide

---

## Step 1: Load Data into Power BI

1. Open **Power BI Desktop**
2. Click **Home → Get Data → Text/CSV**
3. Navigate to `Data/Financial_Raw_Data.csv` and click **Open**
4. In the preview dialog, click **Transform Data** (do NOT click Load directly)

---

## Step 2: Power Query Transformations

Inside the Power Query Editor:

1. **Date column** → Right-click → Change Type → **Date**
2. **Amount column** → Right-click → Change Type → **Fixed Decimal Number**
3. **Category, Sub_Category, Account, Type, Scenario** → Verify they are **Text** type
4. Click **Close & Apply**

---

## Step 3: Create the Calendar Table (DAX)

Go to **Table view** → Click **New Table** and paste:

```dax
Calendar = CALENDAR(MIN('Financial_Raw_Data'[Date]), MAX('Financial_Raw_Data'[Date]))
```

Then add a calculated column in the Calendar table:

```dax
Month = FORMAT('Calendar'[Date], "YYYY-MM")
```

Go to **Model view** → Drag `Financial_Raw_Data[Date]` onto `Calendar[Date]` to create the relationship.

---

## Step 4: Create All DAX Measures

In **Report view**, right-click the `Financial_Raw_Data` table → **New Measure**:

```dax
Total Revenue = 
    CALCULATE(
        SUM(Financial_Raw_Data[Amount]), 
        Financial_Raw_Data[Category] = "Revenue"
    )
```

```dax
Total COGS = 
    CALCULATE(
        SUM(Financial_Raw_Data[Amount]), 
        Financial_Raw_Data[Category] = "COGS"
    )
```

```dax
Total OpEx = 
    CALCULATE(
        SUM(Financial_Raw_Data[Amount]), 
        Financial_Raw_Data[Category] = "Operating Expenses"
    )
```

```dax
Gross Profit = [Total Revenue] - [Total COGS]
```

```dax
Net Profit = [Gross Profit] - [Total OpEx]
```

```dax
Net Profit Margin % = DIVIDE([Net Profit], [Total Revenue], 0)
```

```dax
Gross Profit Margin % = DIVIDE([Gross Profit], [Total Revenue], 0)
```

```dax
Actual Revenue = 
    CALCULATE([Total Revenue], Financial_Raw_Data[Scenario] = "Actual")
```

```dax
Budget Revenue = 
    CALCULATE([Total Revenue], Financial_Raw_Data[Scenario] = "Budget")
```

```dax
Budget Variance = [Actual Revenue] - [Budget Revenue]
```

---

## Step 5: Build the Dashboard Page

### Layout: Place these visuals on a single page named "Financial Overview"

**Row 1 — KPI Cards (top bar)**
- Card 1: `Total Revenue` — Format as currency
- Card 2: `Net Profit` — Format as currency  
- Card 3: `Net Profit Margin %` — Format as percentage
- Card 4: `Gross Profit Margin %` — Format as percentage

**Row 2 — Main Chart**
- Visual: **Line and Clustered Column Chart**
  - X-Axis: `Calendar[Month]`
  - Column Y-Axis: `Total Revenue`, `Total OpEx`
  - Line Y-Axis: `Net Profit Margin %`

**Row 3 — Left Side**
- Visual: **Matrix** (Income Statement layout)
  - Rows: `Category` → `Sub_Category`
  - Columns: `Scenario`
  - Values: `SUM(Amount)`
  - Enable subtotals

**Row 3 — Right Side**
- Visual: **Clustered Bar Chart**
  - Y-Axis: `Sub_Category`
  - X-Axis: `Total Revenue`
  - Legend: `Scenario`

**Slicers Panel**
- Slicer 1: `Scenario` (Tile style)
- Slicer 2: `Category` (Dropdown style)
- Slicer 3: `Calendar[Month]` (Between / Range style)

---

## Step 6: Formatting Tips

- **Theme:** Use "Executive" or import a custom theme (dark blue background, white text)
- **KPI Cards:** Enable "Call out value" and set units to Thousands (K) or Millions (M)
- **Matrix:** Enable conditional formatting on Values column → Color scale Green→Red
- **Page background:** Set to a subtle gray (#F2F2F2) for professional look

---

## Step 7: Save the Report

Save as: `Report/Financial_Health.pbix`
