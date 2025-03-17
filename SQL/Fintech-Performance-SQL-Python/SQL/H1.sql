-- Select the database
USE fintech_analysis;

-- Increase the maximum allowed packet size to 1 GB
SET GLOBAL max_allowed_packet = 1073741824;

-- Retrieve all records from the merged dataset
SELECT * FROM df_merged;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 0. Year-over-year loan count trend
-- This query calculates the annual loan count and its year-over-year growth percentage
SELECT 
    issue_year,
    loan_count,
    LAG(loan_count) OVER (ORDER BY issue_year) AS previous_year_count,
    (loan_count - LAG(loan_count) OVER (ORDER BY issue_year)) * 100.0 / LAG(loan_count) OVER (ORDER BY issue_year) AS yoy_growth_percentage
FROM df_loan_count_by_year_clean
ORDER BY issue_year ASC;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 1. Loan Status Distribution & Aggregation
-- This query categorizes loans based on homeownership status, income range, and loan status
SELECT 
    home_ownership,
    CASE 
        WHEN annual_inc < 50000 THEN '<50K'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN '50K-100K'
        WHEN annual_inc BETWEEN 100001 AND 150000 THEN '100K-150K'
        ELSE '>150K'
    END AS income_range,
    loan_status,
    CASE 
        WHEN loan_status IN ('Fully Paid', 'Current') THEN 'Good Standing'
        WHEN loan_status IN ('Charged Off', 'Default') THEN 'Defaulted'
        WHEN loan_status IN ('In Grace Period') THEN 'Grace Period'
        WHEN loan_status IN ('Late (16-30 days)', 'Late (31-120 days)') THEN 'Late'
        ELSE 'Other'
    END AS loan_status_group,
    COUNT(*) AS loan_count
FROM df_merged
GROUP BY home_ownership, income_range, loan_status, loan_status_group
ORDER BY home_ownership, income_range, loan_status_group, loan_status;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 2. Loan Amount Insights
-- This query calculates the average loan amount based on homeownership status and income range
SELECT 
    home_ownership,
    CASE 
        WHEN annual_inc < 50000 THEN '<50K'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN '50K-100K'
        WHEN annual_inc BETWEEN 100001 AND 150000 THEN '100K-150K'
        ELSE '>150K'
    END AS income_range,
    ROUND(AVG(loan_amount),2) AS avg_loan_amount
FROM df_merged
GROUP BY home_ownership, income_range
ORDER BY home_ownership, income_range;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 3. Loan Status Distribution Rates
-- This query calculates the percentage of different loan statuses across income ranges
SELECT 
    home_ownership,
    CASE 
        WHEN annual_inc < 50000 THEN '<50K'
        WHEN annual_inc BETWEEN 50000 AND 100000 THEN '50K-100K'
        WHEN annual_inc BETWEEN 100001 AND 150000 THEN '100K-150K'
        ELSE '>150K'
    END AS income_range,
    COUNT(CASE WHEN loan_status = 'Default' THEN 1 END) * 100.0 / COUNT(*) AS default_rate,
    COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) * 100.0 / COUNT(*) AS fully_paid_rate,
    COUNT(CASE WHEN loan_status = 'Current' THEN 1 END) * 100.0 / COUNT(*) AS current_rate,
    COUNT(CASE WHEN loan_status = 'Charged off' THEN 1 END) * 100.0 / COUNT(*) AS charged_off_rate,
    COUNT(CASE WHEN loan_status = 'In grace period' THEN 1 END) * 100.0 / COUNT(*) AS in_grace_period_rate,
    COUNT(CASE WHEN loan_status = 'Late (16-30 days)' THEN 1 END) * 100.0 / COUNT(*) AS late_16_to_30_days_rate,
    COUNT(CASE WHEN loan_status = 'Late (31-120 days)' THEN 1 END) * 100.0 / COUNT(*) AS late_31_to_120_days_rate    
FROM df_merged
GROUP BY home_ownership, income_range
ORDER BY home_ownership, income_range;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 4. Loan Status Analysis by Purpose and Verification Status
-- This query analyzes how loan status distribution varies by loan purpose and verification status
SELECT 
    purpose,
    verification_status,
    loan_status,
    COUNT(*) AS status_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY purpose, verification_status), 2) AS status_proportion
FROM df_merged
GROUP BY purpose, verification_status, loan_status
ORDER BY purpose, verification_status, loan_status;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 5. Impact of Employment Length on Loan Performance
-- This query groups employment length into categories and analyzes its impact on loan performance
SELECT 
    CASE 
        WHEN emp_length = 'Unknown' THEN 'Unknown'
        WHEN emp_length LIKE '%< 1%' THEN '< 1 year'
        WHEN emp_length LIKE '%1%' OR emp_length LIKE '%2%' OR emp_length LIKE '%3%' 
             OR emp_length LIKE '%4%' OR emp_length LIKE '%5%' THEN '1-5 years'
        WHEN emp_length LIKE '%6%' OR emp_length LIKE '%7%' OR emp_length LIKE '%8%' 
             OR emp_length LIKE '%9%' OR emp_length LIKE '%10%' THEN '5-10 years'
        ELSE '> 10 years'
    END AS emp_length_category,
    loan_status,
    COUNT(*) AS loan_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (
        PARTITION BY 
            CASE 
                WHEN emp_length = 'Unknown' THEN 'Unknown'
                WHEN emp_length LIKE '%< 1%' THEN '< 1 year'
                WHEN emp_length LIKE '%1%' OR emp_length LIKE '%2%' OR emp_length LIKE '%3%' 
                     OR emp_length LIKE '%4%' OR emp_length LIKE '%5%' THEN '1-5 years'
                WHEN emp_length LIKE '%6%' OR emp_length LIKE '%7%' OR emp_length LIKE '%8%' 
                     OR emp_length LIKE '%9%' OR emp_length LIKE '%10%' THEN '5-10 years'
                ELSE '> 10 years'
            END
    ), 2) AS loan_status_percentage
FROM df_merged
WHERE loan_status IN ('Fully paid', 'Charged off')
GROUP BY emp_length_category, loan_status
ORDER BY emp_length_category, loan_status;

#-----------------------------------------------------------------------------------------------------------------------------------------------#

# 6. Loan Amount vs. Loan Outcome
-- This query categorizes loans into ranges and analyzes their loan outcome
SELECT 
    CASE 
        WHEN loan_amount <= 10000 THEN '0-10K'
        WHEN loan_amount <= 20000 THEN '10K-20K'
        WHEN loan_amount <= 30000 THEN '20K-30K'
        WHEN loan_amount <= 40000 THEN '30K-40K'
        ELSE '>40K'
    END AS loan_amount_range,
    loan_status,
    COUNT(*) AS loan_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY 
        CASE 
            WHEN loan_amount <= 10000 THEN '0-10K'
            WHEN loan_amount <= 20000 THEN '10K-20K'
            WHEN loan_amount <= 30000 THEN '20K-30K'
            WHEN loan_amount <= 40000 THEN '30K-40K'
            ELSE '>40K'
        END
    ), 2) AS loan_status_percentage
FROM df_merged
WHERE loan_status IN ('Fully paid', 'Charged off')
GROUP BY loan_amount_range, loan_status
ORDER BY loan_amount_range, loan_status;
