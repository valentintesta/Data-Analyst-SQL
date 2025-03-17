# Fintech Loan Dashboard


## Overview

The Fintech Loan Dashboard is an interactive web application built using Streamlit and Python, integrating SQL to analyze loan performance, borrower characteristics, and repayment trends. The dashboard provides financial insights through dynamic visualizations, allowing users to explore key metrics such as loan status distribution, annual income vs. loan amount, and default rates.

## Key Features

### **1.** Interactive Filters:
 -  Users can filter data by region, loan status, purpose, issue year, and more.

### **2.** Dynamic Visualizations:
 - Loan purpose breakdown
 - Loan status distribution (pie chart)
 - Year-over-year loan trends
 - Correlation heatmap for key loan features

## **3** Financial Metrics Calculation:
 - Total loan amount
 - Funded amount
 - Interest rates analysis

### **4** User-Friendly UI: 
 - Custom branding with a dark theme and intuitive layout.

## Tech Stack

### Python (Data processing, visualization)
 - Streamlit (Web app framework)
 - Pandas (Data manipulation)
 - Plotly / Seaborn / Matplotlib (Data visualization)
SQL (Data storage & query execution)

## Dataset

The dashboard loads a dataset from a SQL database (fintech_analysis), specifically the df_merged table. The dataset includes borrower information, loan details, and financial indicators.


## Future Improvements
 **- Machine Learning Integration:** Predictive models for loan defaults.
 **- Real-time Data Sync:** Connecting to a live SQL database for updated insights.
 **- Enhanced UI:** More customization options for end users.