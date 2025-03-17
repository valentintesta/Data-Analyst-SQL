# SQL-Homework: Suspicious Transactions Analysis

## Objective:
Analyze historical credit card transactions using SQL to identify potential fraudulent activities.

## Data Modeling:

Developed an entity relationship diagram based on CSV data using Quick Database Diagrams.
Data Engineering:

Created a robust database schema with defined data types, primary keys, and foreign keys.
Imported CSV data into respective tables.

## Data Analysis:

- Consolidated data by creating a credit_card_data view using INNER JOIN across various tables.
- Addressed key questions:
 **1.** Grouping Transactions: How to isolate transactions per cardholder.
 **2.** Time-Specific Analysis (7:00-9:00 a.m.):
 **3.** Identified the top 100 highest transactions.
 **4.** Detected anomalous transactions (notably, several transactions above $1,000 amidst a majority under $20).
 **5**  Counted sub-$2 transactions per cardholder to evaluate potential credit card hacks.
 **6.** Concluded that while some cardholders have more frequent small transactions, there's insufficient evidence to confirm hacking.
