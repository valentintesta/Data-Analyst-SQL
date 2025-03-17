-- Transaction history of cardholder 2
SELECT 
    transaction_date,
    transaction_amt,
    cardholder_id
FROM credit_card_data
WHERE cardholder_id = 2;
