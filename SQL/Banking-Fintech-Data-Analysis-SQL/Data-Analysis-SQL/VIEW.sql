-- Create a view with combined data
CREATE VIEW credit_card_data AS
SELECT 
    ch.cardholder_id,
    ch.name AS cardholder_name,
    c.creditcard_num,
    m.merchant_id,
    m.name AS merchant_name,
    mc.category_name AS merchant_cat_name,
    t.date AS transaction_date,
    t.amount AS transaction_amt
FROM card_holder AS ch
INNER JOIN credit_card AS c
    ON ch.cardholder_id = c.cardholder_id
INNER JOIN transaction AS t
    ON c.creditcard_num = t.creditcard_num
INNER JOIN merchant AS m
    ON t.merchant_id = m.merchant_id
INNER JOIN merchant_category AS mc
    ON m.merchant_cat_id = mc.merchant_cat_id;