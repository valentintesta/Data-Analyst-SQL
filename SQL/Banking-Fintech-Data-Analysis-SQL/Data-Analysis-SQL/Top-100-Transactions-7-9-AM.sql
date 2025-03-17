-- Top 100 highest transactions between 7:00 AM and 9:00 AM
SELECT 
    transaction_date, 
    ROUND(transaction_amt, 2), 
    creditcard_num
FROM credit_card_data
WHERE HOUR(transaction_date) >= 7
    AND HOUR(transaction_date) < 9
ORDER BY transaction_amt DESC
LIMIT 100;
