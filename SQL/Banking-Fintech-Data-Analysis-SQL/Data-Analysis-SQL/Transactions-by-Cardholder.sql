-- Group transactions by cardholder
SELECT 
    cardholder_id,
    cardholder_name,
    SUM(ROUND(transaction_amt, 2)) AS total_transaction_amt
FROM credit_card_data
GROUP BY cardholder_id, cardholder_name
ORDER BY total_transaction_amt DESC;