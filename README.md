# 🏠 Nashville Housing Data Analysis (SQL Project)

## 📊 Overview
This project involves cleaning and analyzing real estate transaction data from Nashville (2013–2016) using SQL. The main objective is to prepare the data for analysis, handle inconsistencies, and derive useful insights from property sales information.

---

## 📁 Dataset
- **Source**: [Kaggle – Nashville Housing Data](https://www.kaggle.com/datasets/tmthyjames/nashville-housing-data)
- **Format**: CSV
- **Rows**: ~56,000+ transactions
- **Fields**: Property ID, Sale Price, Address, Date, Property Type, Owner Info, etc.

---

## 🧹 Data Cleaning Steps
- Created a **staging table** to preserve raw data
- **Removed duplicates** using GROUP BY and MAX(ID)
- **Converted** `Sale Date` column to `DATE` format
- **Populated missing** values in `Address` and `City` from alternative fields
- **Replaced blanks** with `'No Record'` where necessary

---

## 📈 Analysis Performed

### 🏙️ Average Sale Price by City
Calculated the average property sale price grouped by city to identify high-value areas.

### 📅 Total Properties Sold Per Year
Summarized yearly sales trends to spot volume shifts over time.

### 💰 Top 10 Most Expensive Properties
Ranked properties based on sale price to highlight the highest-end transactions in the dataset.

---

## 💻 Tools Used
- **Language**: SQL (MySQL 8+)
- **Environment**: MySQL Workbench / DBeaver
- **Version Control**: Git & GitHub
