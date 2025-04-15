# 👶 Baby Name Trend Analysis with SQL

## 📌 Project Overview
This SQL project explores naming trends in the United States using a simulated `baby_names_db` dataset. The goal is to analyze how the popularity of baby names has evolved over time, highlight the most popular names by gender and year, and identify naming trends across regions.

## 🎯 Objectives
- Track changes in name popularity over time
- Identify names that have experienced significant popularity shifts
- Analyze regional differences in name preferences
- Detect unisex names and their relative popularity across genders

## 🛠️ Tools & Technologies
- SQL (MySQL syntax)
- Window functions (`ROW_NUMBER`, `RANK`)
- CTEs (Common Table Expressions)
- Aggregations and grouping
- Conditional logic and string matching

## 🧩 Database Tables Used
- `names`: Contains baby name data with columns for year, name, gender, and number of births
- `regions`: Maps names to U.S. regions for demographic analysis

## 🔍 Key Analyses
1. **Most Popular Names by Gender (All Time & Yearly)**
   - E.g., `Jessica` and `Michael` identified as top names in their respective genders.
   - Used `SUM(births)` with `GROUP BY` and sorting to determine popularity.

2. **Trend Tracking Over Time**
   - Uses `ROW_NUMBER()` over partitioned years to show rank progression of a name.
   - Focused trend analysis on names like "Michael", "Jessica", and others.

3. **Regional Naming Preferences**
   - Compared name popularity across different U.S. regions using `JOIN` with `regions` table.
   - Identified how regional cultures affect naming conventions.

4. **Rising and Falling Names**
   - Detected names with the highest positive/negative changes in ranking between decades.

5. **Unisex Name Detection**
   - Detected names used for both genders and calculated their usage proportion.

## 📈 Sample Insights
- The name *Michael* consistently ranked in the top 3 for male names between 1970–2000.
- Unisex names like *Jordan* and *Taylor* gained popularity in the 90s across both genders.
- Regional preferences showed that names like *Emily* were more common in the Northeast.

## 📚 What I Learned
- How to use advanced SQL functions (e.g., window functions, CTEs) for trend analysis
- Structuring complex queries using subqueries and temporary result sets
- Gained insights into gender and cultural patterns through data storytelling
