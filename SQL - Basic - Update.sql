Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.

SELECT id, occurred_at, total_amt_usd
  FROM orders
  ORDER BY occurred_at
  LIMIT 10;

Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd
  LIMIT 5;


Write a query to return the bottom 20 orders in terms of least total. Include the id, account_id, and total.
SELECT id, account_id, total
  FROM orders
  ORDER BY total DESC
  LIMIT 20;

Write a query that returns the top 5 rows from orders ordered according to newest to oldest, but with the largest total_amt_usd for each date listed first for each date. You will notice each of these dates shows up as unique because of the time element. When you learn about truncating dates in a later lesson, you will better be able to tackle this question on a day, month, or yearly basis.
SELECT id, occurred_at, total_amt_usd
  FROM orders
  ORDER BY occurred_at, total_amt_usd
  LIMIT 10;

  Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.
SELECT *
  FROM orders
  WHERE gloss_amt_usd >= 1000
  LIMIT 5;


  Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
SELECT *
  FROM orders
  WHERE gloss_amt_usd < 500
  LIMIT 10;


Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) for Exxon Mobil in the accounts table.
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.
SELECT id,
       account_id,
       standard_amt_usd / standard_qty;
FROM orders
LIMIT 10;

Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column). Include the id and account_id fields
SELECT id,
       account_id,
       poster_amt_usd / (gloss_amt_usd + standard_amt_usd + poster_amt_usd)
FROM orders
LIMIT 10;


All the companies whose names start with 'C'.
SELECT id, name
  FROM accounts
  WHERE name like 'C%';

All companies whose names contain the string 'one' somewhere in the name.
SELECT id, name
  FROM accounts
  WHERE name LIKE '$one$';

All companies whose names end with 's'.
SELECT id, name
  FROM accounts
  WHERE name lIKE '$s';

  Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
  FROM accounts
  where name in ('Walmart', 'Target', 'Nordstrom');


  Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
SELECT *
  FROM web_events
  WHERE channel in ('organic', 'adwords');

  Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
  FROM accounts
  where name NOT IN ('Walmart', 'Target', 'Nordstrom');

Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
SELECT *
  FROM orders
  WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty =0;

  Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.
SELECT *
  FROM accounts
  WHERE name NOT LIKE 'C$' AND name NOT LIKE '$S'

  Use the web_events table to find all information regarding individuals who were contacted via organic or adwords and started their account at any point in 2016 sorted from newest to oldest.
SELECT *
  FROM web_events
  WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01';


  Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
SELECT id, gloss_qty, poster_qty
  FROM orders
  WHERE gloss_qty > 4000 OR poster_qty > 4000;


  Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
SELECT id, gloss_qty, poster_qty, standard_qty
  FROM orders
  WHERE standard_qty = 0 AND gloss_qty > 1000 OR poster_qty > 1000;


  Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it does not contain 'eana'
SELECT *
  FROM accounts
  WHERE name LIKE 'C$' OR LIKE 'W$' and primary_poc LIKE 'ana' AND primary_poc LIKE 'Ana' AND primary_poc NOT LIKE 'eana';


SELECT orders.*
  FROM orders
  JOIN accounts
  ON orders.account_is = accounts.id;

SELECT accounts.name, orders.occurred_at
  FROM orders
  JOIN account_is
    ON orders.account_id = accounts.id;


SELECT *
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id;

  SELECT orders.standard_qty, orders.poster_qty, accounts.website, accounts.primary_poc
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

    Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
SELECT a.primary_poc,w.occurred_at, w.channel, a.name
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.name = 'Walmart'


Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name reg, s.name rep, a.name account
FROM sales_rep s
JOIN region r
ON r.id = s.region_id
JOIN accounts a
WHERE s.id = a.id
ORDER BY s.name

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
SELECT r.name reg, a.name account, o.total_amt_usd / (o.total + 0.1) unit_price
FROM region r
JOIN sales_rep s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.id
JOIN orders o
ON a.id = o.account_id;

Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name sales_rep, a.name account
FROM region r
JOIN sales_reps s
  ON s.region_id = r.id
 AND r.name = 'Midwest'
JOIN accounts a
  ON a.sales_rep_id = s.id
ORDER By s.name;


Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name sales_rep, a.name account
FROM region r
JOIN sales_reps s
  ON s.region_id = r.id
 AND r.name = 'Midwest'
 AND s.name LIKE 'S%'
JOIN accounts a
  ON a.sales_rep_id = s.id
ORDER By a.name;

SELECT r.name region, s.name sales_rep, a.name account
FROM region r
JOIN sales_reps s
  ON s.region_id = r.id
 AND r.name = 'Midwest'
 AND s.name LIKE '% k%'
JOIN accounts a
  ON a.sales_rep_id = s.id
ORDER By a.name;


SELECT r.name region, a.name account, o.total_amt_usd / (o.total + 0.1) unit_price
  FROM region r
  JOIN sales_reps s
    ON s.region_id = r.id
  JOIN accounts a
    ON a.sales_rep_id = s.id
  JOIN orders o
    ON o.account_id = a.id
 WHERE o.standard_qty > 100


 SELECT r.name region, a.name account, o.total_amt_usd / (o.total + 0.1) unit_price
   FROM region r
   JOIN sales_reps s
     ON s.region_id = r.id
   JOIN accounts a
     ON a.sales_rep_id = s.id
   JOIN orders o
     ON o.account_id = a.id
  WHERE o.standard_qty > 100 AND o.poster_qty > 50
  ORDER BY unit_price


  SELECT r.name region, a.name account, o.total_amt_usd / (o.total + 0.1) unit_price
    FROM region r
    JOIN sales_reps s
      ON s.region_id = r.id
    JOIN accounts a
      ON a.sales_rep_id = s.id
    JOIN orders o
      ON o.account_id = a.id
   WHERE o.standard_qty > 100 AND o.poster_qty > 50
   ORDER BY unit_price DESC

   
