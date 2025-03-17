-- Top 5 merchants prone to being hacked (small transactions)
SELECT
    merchant_name, 
    merchant_cat_name,
    COUNT(transaction_amt) AS small_transactions
FROM credit_card_data
WHERE transaction_amt <= 2
GROUP BY merchant_name, merchant_cat_name
ORDER BY small_transactions DESC
LIMIT 5;
