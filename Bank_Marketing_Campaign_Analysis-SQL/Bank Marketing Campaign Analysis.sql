SELECT * FROM bank;

-- Total number of successful deposits
SELECT 
    COUNT(*) AS total_deposits
FROM 
    bank
WHERE 
    deposit = 'yes';

-- Total number of contacts made
SELECT 
    COUNT(*) AS total_contacts
FROM 
    bank;

-- Success rate (percentage of successful deposits out of total contacts)
SELECT 
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank;

-- Number of deposits by job with total contacts for each job and response rate
SELECT 
    job,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    job
ORDER BY 
    success_rate DESC;

-- Number of deposits by education level with total contacts for each level and response rate
SELECT 
    education,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    education
ORDER BY 
    success_rate DESC;

-- Number of deposits by marital status with total contacts for each status and response rate
SELECT 
    marital,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    marital
ORDER BY 
    success_rate DESC;

-- Average campaign duration for both successful and unsuccessful deposits
SELECT 
    deposit,
    AVG(duration) AS avg_duration
FROM 
    bank
GROUP BY 
    deposit;

-- Success rate by previous campaign outcome with total contacts and successful deposits for each outcome
SELECT 
    poutcome,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    poutcome;

-- Age distribution of successful deposits grouped by age ranges
SELECT 
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and above'
    END AS age_group,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    age_group
ORDER BY 
    success_rate DESC;

-- Analysis of deposit success based on contact method
SELECT 
    contact,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    contact
ORDER BY 
    success_rate DESC;

-- Impact of campaign frequency (number of contacts) on success rate
SELECT 
    campaign,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    campaign
ORDER BY 
    campaign;

-- Analysis of deposits based on balance ranges to see how financial status affects engagement
SELECT 
    CASE 
        WHEN balance < 0 THEN 'Negative Balance'
        WHEN balance BETWEEN 0 AND 1000 THEN '0-1000'
        WHEN balance BETWEEN 1001 AND 5000 THEN '1001-5000'
        WHEN balance BETWEEN 5001 AND 10000 THEN '5001-10000'
        ELSE '10001 and above'
    END AS balance_range,
    COUNT(*) AS total_contacts,
    COUNT(*) FILTER (WHERE deposit = 'yes') AS successful_deposits,
    (COUNT(*) FILTER (WHERE deposit = 'yes') * 100.0 / COUNT(*)) AS success_rate
FROM 
    bank
GROUP BY 
    balance_range
ORDER BY 
    success_rate DESC;
