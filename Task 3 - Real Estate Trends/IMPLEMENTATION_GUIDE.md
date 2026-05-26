# Task 3 — Real Estate Market Trends Dashboard

## Step-by-Step Implementation Guide

---

## Step 0: Enable Map Visuals (REQUIRED FIRST)

1. Go to **File → Options and Settings → Options**
2. Navigate to **Global → Security**
3. Check ✅ **"Use Map and Filled Map visuals"**
4. Click OK and restart Power BI Desktop

---

## Step 1: Load Data

1. **Home → Get Data → Text/CSV**
2. Select `Data/Real_Estate_Market_Data.csv`
3. Click **Transform Data**

---

## Step 2: Power Query Transformations

In Power Query Editor:

1. **Latitude, Longitude** → Change Type → **Decimal Number**
2. **Price, PricePerSqM, MonthlyRent** → Change Type → **Fixed Decimal Number**
3. **AnnualRentalYield** → Change Type → **Decimal Number**
4. **DemandScore, SupplyCount, Bedrooms, SizeSqM, DaysonMarket** → **Whole Number**
5. **ListingDate** → Change Type → **Date**
6. **City, Neighborhood, PropertyType, EconomicIndicator** → Verify as **Text**

**Add a Market Tier column:**
- **Add Column → Conditional Column**
  - Name: `MarketTier`
  - If `DemandScore` ≥ 85 → "Hot Market"
  - Else if `DemandScore` ≥ 70 → "Active Market"
  - Else → "Slow Market"

**Add Yield Category column:**
- **Add Column → Conditional Column**
  - Name: `YieldTier`
  - If `AnnualRentalYield` ≥ 0.08 → "High Yield (8%+)"
  - Else if `AnnualRentalYield` ≥ 0.065 → "Medium Yield"
  - Else → "Low Yield (<6.5%)"

7. Click **Close & Apply**

---

## Step 3: Set Geographic Data Categories

In **Data view**:
1. Click the `Latitude` column → In the ribbon, set **Data Category = Latitude**
2. Click the `Longitude` column → Set **Data Category = Longitude**
3. Click the `City` column → Set **Data Category = City**
4. Click the `Neighborhood` column → Set **Data Category = Place**

---

## Step 4: Create All DAX Measures

```dax
Average Price = AVERAGE(Real_Estate_Market_Data[Price])
```

```dax
Average Price Per SqM = AVERAGE(Real_Estate_Market_Data[PricePerSqM])
```

```dax
Average Yield % = AVERAGE(Real_Estate_Market_Data[AnnualRentalYield])
```

```dax
Total Available Properties = SUM(Real_Estate_Market_Data[SupplyCount])
```

```dax
Avg Demand Score = AVERAGE(Real_Estate_Market_Data[DemandScore])
```

```dax
Avg Days on Market = AVERAGE(Real_Estate_Market_Data[DaysonMarket])
```

```dax
Avg Monthly Rent = AVERAGE(Real_Estate_Market_Data[MonthlyRent])
```

```dax
High Yield Properties = 
    CALCULATE(
        COUNT(Real_Estate_Market_Data[PropertyID]),
        Real_Estate_Market_Data[AnnualRentalYield] >= 0.075
    )
```

```dax
Hot Market Properties = 
    CALCULATE(
        COUNT(Real_Estate_Market_Data[PropertyID]),
        Real_Estate_Market_Data[DemandScore] >= 85
    )
```

```dax
Price to Rent Ratio = 
    DIVIDE([Average Price], [Avg Monthly Rent] * 12, 0)
```

```dax
Investment Score = 
    DIVIDE(
        [Avg Demand Score] * [Average Yield %] * 1000,
        [Avg Days on Market],
        0
    )
```

---

## Step 5: Build the Dashboard

### Page 1: "Market Map View"

**Top KPI Cards (Row 1)**
- Avg Property Price: `Average Price`
- Avg Rental Yield: `Average Yield %` (format as %)
- Hot Market Properties: `Hot Market Properties`
- Avg Demand Score: `Avg Demand Score`

**Main Visual: Bubble Map**
1. Insert → **Map** visual
2. Drag `Latitude` → Latitude field
3. Drag `Longitude` → Longitude field
4. Drag `Neighborhood` → Location field
5. Drag `DemandScore` → Bubble size field
6. Drag `City` → Legend field
7. Drag `Average Price` → Tooltips

**Alternative Heat Map:**
1. In the Map visual → Format → Visual → Toggle **Heat Map = ON**
2. Set Color saturation to `DemandScore`

**Slicers:**
- `City` (Tile style)
- `PropertyType` (Dropdown)
- `EconomicIndicator` (Tile style)

---

### Page 2: "Investment Analysis"

**Clustered Column Chart (Neighborhood Comparison)**
- X-Axis: `Neighborhood`
- Column Y-Axis: `Average Price`
- Line Y-Axis: `Average Yield %`
- Legend: `City`
- Sort by: `Investment Score` descending

**Donut Chart (Property Type Distribution)**
- Legend: `PropertyType`
- Values: Count of `PropertyID`

**Scatter Plot (Price vs Yield)**
- X-Axis: `Average Price`
- Y-Axis: `Average Yield %`
- Details: `Neighborhood`
- Legend: `EconomicIndicator`
- Size: `Avg Demand Score`

---

### Page 3: "Market Supply & Demand"

**Bar Chart: Supply vs Demand by Neighborhood**
- Y-Axis: `Neighborhood`
- X-Axis 1: `Total Available Properties` (supply)
- X-Axis 2: `Avg Demand Score`

**Table: Investment Rankings**
- Columns: Neighborhood, City, Avg Price, Avg Yield %, Demand Score, Days on Market, Investment Score
- Sort by Investment Score descending
- Apply conditional formatting:
  - Investment Score: Green gradient
  - Days on Market: Red (high = bad) to Green (low = fast sale)

---

## Step 6: Formatting Tips

- **Map visual:** Set default zoom to Egypt region (center lat: 26.8, long: 30.8)
- **Currency:** Format all price measures as EGP or USD consistently
- **Yield %:** Format as Percentage with 2 decimal places
- **Tooltips:** Add rich tooltips showing Price, Yield, Demand, and Days on Market together

---

## Step 7: Save

Save as: `Report/Real_Estate_Trends.pbix`
