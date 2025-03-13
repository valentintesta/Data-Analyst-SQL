---

# 📊 Bank Marketing Campaign Analysis: Uncovering What Works

In this project, I analyzed data from a bank’s marketing campaigns to reveal factors that drive customer engagement. By exploring patterns in demographics, financial status, and previous campaign outcomes, I aimed to uncover what influences customers to make a deposit. This analysis provides insights that can guide future strategies, helping the bank target the right audiences with the most effective messages.

---

### 📌 Analysis Highlights:
* **Who** is more likely to respond positively to the campaign?
* **Which demographics and financial factors** show higher engagement rates?
* **How does contact frequency and previous campaign outcome** impact deposit success?

---

## Key Insights and Visuals

### 1. Total Successful Deposits and Success Rate
Understanding the baseline for overall engagement by identifying the number of successful deposits and the success rate among all contacts provides a foundation for evaluating campaign effectiveness.

```sql
-- Total number of successful deposits
SELECT COUNT(*) AS total_deposits FROM bank WHERE deposit = 'yes';

-- Success rate calculation
SELECT (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank;
```

**Takeaway:** Knowing the total deposits and success rate helps establish a baseline for evaluating the impact of different factors on engagement.

---

### 2. Deposits by Job Type
Analyzing deposits by job type helps identify which job roles are most receptive to the campaign, potentially allowing the bank to personalize future approaches based on occupation.

```sql
-- Number of deposits by job with response rate
SELECT job, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY job ORDER BY success_rate DESC;
```

**Takeaway:** This breakdown shows which occupations have the highest engagement, allowing the bank to customize its messaging for specific job roles.

---

### 3. Deposits by Education Level
Investigating deposits by education level reveals trends that indicate which educational backgrounds are more responsive to the bank’s offerings.

```sql
-- Number of deposits by education level with response rate
SELECT education, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY education ORDER BY success_rate DESC;
```

**Takeaway:** Education level can influence how customers perceive banking products, helping to tailor marketing messages based on educational demographics.

---

### 4. Deposits by Marital Status
By understanding how marital status affects deposit rates, the bank can gain insight into customer priorities based on life stages, allowing more targeted messaging.

```sql
-- Number of deposits by marital status with response rate
SELECT marital, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY marital ORDER BY success_rate DESC;
```

**Takeaway:** Marital status appears to influence financial decisions, which may be useful for customizing the bank’s offers based on life stage.

---

### 5. Campaign Duration Impact on Success
Examining the average duration of successful and unsuccessful campaigns helps determine if longer engagements increase the likelihood of deposits.

```sql
-- Average duration for both successful and unsuccessful deposits
SELECT deposit, AVG(duration) AS avg_duration FROM bank GROUP BY deposit;
```

**Takeaway:** Knowing whether longer conversations yield higher deposits can inform training and script adjustments for customer service teams.

---

### 6. Success Rate by Previous Campaign Outcome
Assessing success rates based on previous campaign outcomes helps determine the influence of past experiences on current engagements.

```sql
-- Success rate by previous campaign outcome
SELECT poutcome, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY poutcome;
```

**Takeaway:** Understanding how previous outcomes influence current decisions provides insight into the importance of maintaining positive relationships over time.

---

### 7. Age Group Analysis
Grouping age ranges allows us to identify the engagement trends among different age groups, which can guide age-specific marketing approaches.

```sql
-- Age distribution of successful deposits by age ranges
SELECT CASE WHEN age < 20 THEN 'Under 20' WHEN age BETWEEN 20 AND 29 THEN '20-29' WHEN age BETWEEN 30 AND 39 THEN '30-39' WHEN age BETWEEN 40 AND 49 THEN '40-49' WHEN age BETWEEN 50 AND 59 THEN '50-59' ELSE '60 and above' END AS age_group, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY age_group ORDER BY success_rate DESC;
```

**Takeaway:** Knowing which age groups are most likely to deposit enables the bank to develop tailored marketing messages that resonate with different life stages.

---

### 8. Contact Method Effectiveness
Analyzing success by contact method provides insight into which methods (e.g., phone or email) are more effective for customer engagement.

```sql
-- Analysis of deposit success based on contact method
SELECT contact, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY contact ORDER BY success_rate DESC;
```

**Takeaway:** This insight can help allocate resources towards the most successful contact methods, potentially boosting campaign effectiveness.

---

### 9. Frequency of Contact (Campaign Count)
By analyzing success rates based on the number of contacts, the bank can optimize how often they reach out to maximize positive responses.

```sql
-- Impact of campaign frequency on success rate
SELECT campaign, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY campaign ORDER BY campaign;
```

**Takeaway:** Understanding the optimal number of contacts helps balance between engagement and over-communication.

---

### 10. Deposit Success by Financial Balance
Segmenting deposit success by account balance allows the bank to see if financial stability affects the likelihood of deposits, which is valuable for targeting and message personalization.

```sql
-- Deposits based on balance ranges
SELECT CASE WHEN balance < 0 THEN 'Negative Balance' WHEN balance BETWEEN 0 AND 1000 THEN '0-1000' WHEN balance BETWEEN 1001 AND 5000 THEN '1001-5000' WHEN balance BETWEEN 5001 AND 10000 THEN '5001-10000' ELSE '10001 and above' END AS balance_range, COUNT(*) AS total_contacts, COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits, (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate FROM bank GROUP BY balance_range ORDER BY success_rate DESC;
```

**Takeaway:** Insights into financial readiness can help shape messaging to ensure it aligns with customers’ financial circumstances.

---
