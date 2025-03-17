USE fintech_analysis;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 1. Repayment Rate by Region
-- This query calculates the repayment rate per region, measuring the percentage of fully paid loans.
SELECT 
    region,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS repayment_rate,
    COUNT(*) AS total_loans,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) AS fully_paid_loans
FROM df_merged
GROUP BY region
ORDER BY repayment_rate DESC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 2. Income Distribution by Region
-- This query groups borrowers into income ranges and counts the number of loans issued in each category per region.
SELECT 
    region,
    CASE 
        WHEN annual_inc < 50000 THEN '<50K'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN '50K-100K'
        WHEN annual_inc BETWEEN 100001 AND 150000 THEN '100K-150K'
        ELSE '>150K'
    END AS income_range,
    COUNT(*) AS loan_count
FROM df_merged
GROUP BY region, income_range
ORDER BY region, income_range;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 3. Homeownership by Region
-- This query analyzes loan distribution by homeownership status across regions, including the fully paid loan rate.
SELECT 
    region,
    home_ownership,
    COUNT(*) AS loan_count,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate
FROM df_merged
GROUP BY region, home_ownership
ORDER BY region, fully_paid_rate DESC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 4. Employment Length by Region
-- This query analyzes loan distribution based on employment length and repayment performance across regions.
SELECT 
    region,
    emp_length,
    COUNT(*) AS loan_count,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate
FROM df_merged
GROUP BY region, emp_length
ORDER BY region, emp_length;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 5. Loan Purpose Distribution by Region
-- This query examines loan distribution based on loan purpose in each region and calculates the fully paid loan rate.
SELECT 
    region,
    purpose,
    COUNT(*) AS loan_count,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate
FROM df_merged
GROUP BY region, purpose
ORDER BY region, fully_paid_rate DESC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 6. Repayment Rates by Income Group
-- This query measures the repayment rate across different income groups in each region.
SELECT 
    region, 
    CASE 
        WHEN annual_inc < 50000 THEN '<50K'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN '50K-100K'
        WHEN annual_inc BETWEEN 100000 AND 150000 THEN '100K-150K'
        ELSE '>150K'
    END AS income_group,
    COUNT(*) AS loan_count,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate
FROM df_merged
GROUP BY region, income_group
ORDER BY fully_paid_rate DESC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 7. Repayment Rates by Loan Purpose
-- This query evaluates repayment performance for different loan purposes across regions.
SELECT 
    region,
    purpose,
    COUNT(*) AS loan_count,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate
FROM df_merged
GROUP BY region, purpose
ORDER BY fully_paid_rate DESC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 8. Repayment Rates by Loan Term
-- This query compares repayment performance based on different loan terms across regions.
SELECT 
    region,
    term,
    COUNT(*) AS loan_count,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate
FROM df_merged
GROUP BY region, term
ORDER BY fully_paid_rate DESC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#
