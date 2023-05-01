-- Selecting all parameters needed for the analysis from the database
SELECT
	ord.order_id,
    -- Creating a new column (customer) from the concatenation of first_name and last_name columns in the customers table
    concat(cus.first_name, ' ', cus.last_name) AS 'customer',
    cus.city,
    cus.state,
    ord.order_date,
    -- Creating a new calculated field (total_units) by taking the sum of all the quantity of product(s) purchased by each customer in the customers table
   SUM(ite.quantity) AS 'total_units',
   -- Creating a new calculated field (Revenue) by multiplying the quantity and list_price in the items table
   SUM(ite.quantity * ite.list_price) AS 'Revenue',
   -- Renaming product_name as product
   pro.product_name AS product,
   -- Renaming category_name as category
   cat.category_name AS category,
   -- Renaming brand_name as brand 
   bra.brand_name AS brand,
   -- Renaming store_name as store
   sto.store_name AS store,
   -- Creating a new column (sales_rep) from the concatenation of first_name and last_name column in the staffs table
   concat(sta.first_name, ' ', sta.last_name ) AS 'sales_rep'
   
-- Specifyig the tables from which we're selecting the columns   
FROM
sales.orders ord
-- Using join to combine various tables together depending on their primary and secondary key
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id
JOIN production.products pro
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN production.brands bra
ON pro.brand_id = bra.brand_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON sto.store_id = sta.store_id

-- Grouping by all selected columns except the calculated fields
GROUP BY
	ord.order_id,
    concat(cus.first_name, ' ', cus.last_name),
    cus.city,
    cus.state,
    ord.order_date,
    pro.product_name,
    cat.category_name,
    bra.brand_name,
    sto.store_name,
    concat(sta.first_name, ' ', sta.last_name )
    
    