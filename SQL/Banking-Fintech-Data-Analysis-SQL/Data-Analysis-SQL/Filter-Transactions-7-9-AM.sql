-- Filter transactions between 7:00 AM and 9:00 AM
SELECT 
    transaction_date, 
    transaction_amt, 
    creditcard_num
FROM credit_card_data
WHERE HOUR(transaction_date) >= 7
    AND HOUR(transaction_date) < 9;
