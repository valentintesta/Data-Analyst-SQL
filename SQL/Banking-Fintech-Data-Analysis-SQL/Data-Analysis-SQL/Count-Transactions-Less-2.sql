-- Count transactions less than $2 per cardholder
SELECT
    cardholder_id, 
    cardholder_name, 
    COUNT(transaction_amt) AS small_transactions
FROM credit_card_data
WHERE transaction_amt <= 2
GROUP BY cardholder_id, cardholder_name
ORDER BY small_transactions DESC;
