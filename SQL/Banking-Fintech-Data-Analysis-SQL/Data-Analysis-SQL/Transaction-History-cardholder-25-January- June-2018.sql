-- Transaction history of cardholder 25 from January to June 2018
SELECT 
    transaction_date,
    transaction_amt,
    cardholder_id
FROM credit_card_data
WHERE cardholder_id = 25
    AND MONTH(transaction_date) <= 6
    AND YEAR(transaction_date) = 2018;
