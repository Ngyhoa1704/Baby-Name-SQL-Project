# 👶 Baby Names SQL Project

## 📌 Project Overview
This SQL project explores trends in baby name popularity across the United States using the `baby_names_db` database. The analysis covers temporal patterns, regional differences, gender-neutral names, and naming extremes. It uses advanced SQL features such as window functions, CTEs, and joins to uncover insights in naming behavior from 1980 to 2009.

---

## 🗃️ Database Structure

- `names`: Contains baby name, gender, state, year, and number of births
- `regions`: Maps U.S. states to their respective regions

---

## 🎯 Analysis Objectives

### 1️⃣ Track Changes in Name Popularity Over Time
- Identify the all-time most popular boy (`Michael`) and girl (`Jessica`) names
- Track how their **popularity rank changed year over year**
- Calculate **names with the biggest ranking jumps** from 1980 to 2009

### 2️⃣ Compare Popularity Across Time Periods
- Retrieve the **top 3 names per gender for each year**
- Repeat the same analysis **per decade** using `FLOOR(year/10) * 10`

### 3️⃣ Compare Popularity Across Regions
- Clean and fix missing region mappings (e.g., Michigan → Midwest)
- Count **total births per U.S. region**
- Retrieve **top 3 girl and boy names** per region using `ROW_NUMBER()`

### 4️⃣ Explore Unique and Extreme Names
- Identify the **top 10 androgynous names** (used by both genders)
- Find the **shortest and longest names**, then rank the most popular within each
- Calculate the **state with the highest percentage of babies named "Chris"**

---

## 🛠 SQL Techniques Used

- **Aggregation**: `SUM()`, `COUNT()`
- **Date functions**: `FLOOR()`, `YEAR()`
- **Window functions**: `ROW_NUMBER()`, `RANK()`
- **String functions**: `LENGTH()`, `GROUP_CONCAT()`
- **Conditional logic**: `CASE WHEN`
- **Common Table Expressions (CTEs)** for modular queries
- **JOINs** and `UNION` for dataset enrichment and regional mapping

---

## 📂 File Included
- `Baby_Names_Analysis.sql` – Complete SQL script organized by objective with clear comments and task labeling

---

## 📚 What This Project Demonstrates
- Proficiency in SQL for demographic and behavioral data analysis
- Ability to clean, transform, and enrich raw data using SQL logic
- Strong use of window functions and modular querying for multi-level insights
- Real-world application of SQL in social and cultural trend analysis

---

> 🎯 Ideal for data analysts and SQL learners exploring longitudinal, demographic, or geographic data storytelling.
