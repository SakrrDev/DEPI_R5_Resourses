-- 1
SELECT *
FROM products;


-- 2
SELECT name, sale_price
FROM products
WHERE is_active = TRUE;


-- 3
SELECT *
FROM products
WHERE sale_price > 30
  AND is_active = TRUE
ORDER BY sale_price DESC;


-- 4
SELECT *
FROM products
WHERE purchase_price < 20
  AND is_active = TRUE
ORDER BY purchase_price ASC;


-- 5
SELECT *
FROM products
WHERE sale_price BETWEEN 20 AND 50
  AND is_active = TRUE
ORDER BY sale_price;


-- 6
SELECT *
FROM products
WHERE is_active = TRUE
  AND sale_price > 0
ORDER BY name;


-- 7
SELECT *
FROM suppliers
WHERE balance > 0
  AND is_active = TRUE
ORDER BY balance DESC;


-- 8
SELECT *
FROM customers
WHERE balance = 0
  AND is_active = TRUE
ORDER BY name;


-- 9
SELECT *
FROM products
WHERE min_stock > 20
  AND is_active = TRUE
ORDER BY min_stock DESC;


-- 10
SELECT *
FROM products
WHERE name ILIKE '%Milk%'
  AND is_active = TRUE
ORDER BY name;


-- 11
SELECT *
FROM products
WHERE is_active = TRUE
ORDER BY name ASC;


-- 12
SELECT *
FROM products
WHERE is_active = TRUE
  AND sale_price > 0
ORDER BY sale_price DESC;


-- 13
SELECT name, sale_price
FROM products
WHERE is_active = TRUE
  AND sale_price > 0
ORDER BY sale_price DESC
LIMIT 5;


-- 14
SELECT name, sale_price
FROM products
WHERE is_active = TRUE
  AND sale_price > 0
ORDER BY sale_price ASC
LIMIT 5;


-- 15
SELECT
    invoice_number,
    invoice_date,
    total_amount,
    paid_amount,
    remaining_amount
FROM sales_invoices
WHERE total_amount > 0
ORDER BY invoice_date DESC
LIMIT 5;


-- 16
SELECT name, balance
FROM suppliers
WHERE is_active = TRUE
  AND balance >= 0
ORDER BY balance DESC;


-- 17
SELECT
    p.name AS product_name,
    c.name AS category_name
FROM products p
JOIN categories c
    ON p.category_id = c.id
WHERE p.is_active = TRUE
ORDER BY c.name, p.name;


-- 18
SELECT
    p.id,
    p.name,
    p.sale_price,
    p.purchase_price
FROM products p
JOIN categories c
    ON p.category_id = c.id
WHERE c.name = 'Drinks'
  AND p.is_active = TRUE
ORDER BY p.name;


-- 19
SELECT
    p.id,
    p.name,
    p.sale_price,
    p.purchase_price
FROM products p
JOIN categories c
    ON p.category_id = c.id
WHERE c.name = 'Dairy'
  AND p.is_active = TRUE
ORDER BY p.name;


-- 20
SELECT
    pi.invoice_number,
    s.name AS supplier_name,
    pi.invoice_date,
    pi.total_amount
FROM purchase_invoices pi
JOIN suppliers s
    ON pi.supplier_id = s.id
WHERE pi.total_amount > 0
ORDER BY pi.invoice_date;


-- 21
SELECT
    si.invoice_number,
    c.name AS customer_name,
    si.invoice_date,
    si.total_amount
FROM sales_invoices si
JOIN customers c
    ON si.customer_id = c.id
WHERE si.total_amount > 0
ORDER BY si.invoice_date;


-- 22
SELECT
    si.invoice_number,
    COALESCE(c.name, 'Walk-in Customer') AS customer_name,
    si.invoice_date,
    si.total_amount
FROM sales_invoices si
LEFT JOIN customers c
    ON si.customer_id = c.id
WHERE si.total_amount > 0
ORDER BY si.invoice_date;


-- 23
SELECT
    si.invoice_number,
    p.name AS product_name,
    sai.quantity,
    sai.sale_price,
    sai.total
FROM sales_invoices si
JOIN sale_items sai
    ON si.id = sai.sales_invoice_id
JOIN products p
    ON sai.product_id = p.id
WHERE sai.quantity > 0
ORDER BY si.invoice_number, p.name;


-- 24
SELECT
    pi.invoice_number,
    s.name AS supplier_name,
    p.name AS product_name,
    pri.quantity,
    pri.purchase_price,
    pri.total
FROM purchase_invoices pi
JOIN suppliers s
    ON pi.supplier_id = s.id
JOIN purchase_items pri
    ON pi.id = pri.purchase_invoice_id
JOIN products p
    ON pri.product_id = p.id
WHERE pri.quantity > 0
ORDER BY pi.invoice_number, p.name;


-- 25
SELECT COUNT(*) AS products_count
FROM products
WHERE is_active = TRUE;


-- 26
SELECT AVG(sale_price) AS average_sale_price
FROM products
WHERE is_active = TRUE
  AND sale_price > 0;


-- 27
SELECT MAX(sale_price) AS highest_sale_price
FROM products
WHERE is_active = TRUE;


-- 28
SELECT MIN(sale_price) AS lowest_sale_price
FROM products
WHERE is_active = TRUE
  AND sale_price > 0;


-- 29
SELECT SUM(total_amount) AS total_sales
FROM sales_invoices
WHERE total_amount > 0;


-- 30
SELECT SUM(total_amount) AS total_purchases
FROM purchase_invoices
WHERE total_amount > 0;


-- 31
SELECT SUM(paid_amount) AS total_paid_sales
FROM sales_invoices
WHERE paid_amount > 0;


-- 32
SELECT SUM(remaining_amount) AS total_customer_remaining
FROM sales_invoices
WHERE remaining_amount > 0;


-- 33
SELECT SUM(remaining_amount) AS total_supplier_remaining
FROM purchase_invoices
WHERE remaining_amount > 0;


-- 34
SELECT
    c.name AS category_name,
    COUNT(p.id) AS products_count
FROM categories c
LEFT JOIN products p
    ON c.id = p.category_id
WHERE c.name IS NOT NULL
GROUP BY c.id, c.name
ORDER BY products_count DESC;


-- 35
SELECT
    c.name AS category_name,
    AVG(p.sale_price) AS average_sale_price
FROM categories c
JOIN products p
    ON c.id = p.category_id
WHERE p.is_active = TRUE
GROUP BY c.id, c.name
ORDER BY average_sale_price DESC;


-- 36
SELECT
    c.name AS category_name,
    MAX(p.sale_price) AS highest_sale_price
FROM categories c
JOIN products p
    ON c.id = p.category_id
WHERE p.is_active = TRUE
GROUP BY c.id, c.name
ORDER BY highest_sale_price DESC;


-- 37
SELECT
    c.name AS customer_name,
    SUM(si.total_amount) AS total_sales
FROM customers c
JOIN sales_invoices si
    ON c.id = si.customer_id
WHERE si.total_amount > 0
GROUP BY c.id, c.name
ORDER BY total_sales DESC;


-- 38
SELECT
    c.name AS customer_name,
    COUNT(si.id) AS invoice_count
FROM customers c
JOIN sales_invoices si
    ON c.id = si.customer_id
WHERE si.total_amount > 0
GROUP BY c.id, c.name
ORDER BY invoice_count DESC;


-- 39
SELECT
    s.name AS supplier_name,
    SUM(pi.total_amount) AS total_purchases
FROM suppliers s
JOIN purchase_invoices pi
    ON s.id = pi.supplier_id
WHERE pi.total_amount > 0
GROUP BY s.id, s.name
ORDER BY total_purchases DESC;


-- 40
SELECT
    s.name AS supplier_name,
    COUNT(pi.id) AS invoice_count
FROM suppliers s
JOIN purchase_invoices pi
    ON s.id = pi.supplier_id
WHERE pi.total_amount > 0
GROUP BY s.id, s.name
ORDER BY invoice_count DESC;


-- 41
SELECT
    p.name AS product_name,
    SUM(sai.quantity) AS total_quantity_sold
FROM products p
JOIN sale_items sai
    ON p.id = sai.product_id
WHERE sai.quantity > 0
GROUP BY p.id, p.name
ORDER BY total_quantity_sold DESC;


-- 42
SELECT
    p.name AS product_name,
    SUM(sai.quantity) AS total_quantity_sold
FROM products p
JOIN sale_items sai
    ON p.id = sai.product_id
WHERE sai.quantity > 0
GROUP BY p.id, p.name
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- 43
SELECT
    c.name AS category_name,
    COUNT(p.id) AS products_count
FROM categories c
JOIN products p
    ON c.id = p.category_id
WHERE p.is_active = TRUE
GROUP BY c.id, c.name
HAVING COUNT(p.id) > 3
ORDER BY products_count DESC;


-- 44
SELECT
    c.name AS customer_name,
    SUM(si.total_amount) AS total_purchases
FROM customers c
JOIN sales_invoices si
    ON c.id = si.customer_id
WHERE si.total_amount > 0
GROUP BY c.id, c.name
HAVING SUM(si.total_amount) > 200
ORDER BY total_purchases DESC;


-- 45
SELECT
    s.name AS supplier_name,
    SUM(pi.total_amount) AS total_purchases
FROM suppliers s
JOIN purchase_invoices pi
    ON s.id = pi.supplier_id
WHERE pi.total_amount > 0
GROUP BY s.id, s.name
HAVING SUM(pi.total_amount) > 2000
ORDER BY total_purchases DESC;


-- 46
SELECT
    p.name AS product_name,
    SUM(sai.quantity) AS total_quantity_sold
FROM products p
JOIN sale_items sai
    ON p.id = sai.product_id
WHERE sai.quantity > 0
GROUP BY p.id, p.name
HAVING SUM(sai.quantity) > 5
ORDER BY total_quantity_sold DESC;


-- 47
SELECT
    c.name AS category_name,
    AVG(p.sale_price) AS average_sale_price
FROM categories c
JOIN products p
    ON c.id = p.category_id
WHERE p.is_active = TRUE
GROUP BY c.id, c.name
HAVING AVG(p.sale_price) > 30
ORDER BY average_sale_price DESC;


-- 48
SELECT
    name,
    sale_price
FROM products
WHERE is_active = TRUE
  AND sale_price = (
      SELECT MAX(sale_price)
      FROM products
      WHERE is_active = TRUE
  );


-- 49
SELECT
    name,
    sale_price
FROM products
WHERE is_active = TRUE
  AND sale_price = (
      SELECT MIN(sale_price)
      FROM products
      WHERE is_active = TRUE
        AND sale_price > 0
  );


-- 50
SELECT
    p.name AS product_name,
    SUM(sai.quantity) AS total_quantity_sold
FROM products p
JOIN sale_items sai
    ON p.id = sai.product_id
WHERE sai.quantity > 0
GROUP BY p.id, p.name
ORDER BY total_quantity_sold DESC
LIMIT 1;


-- 51
SELECT
    c.name AS category_name,
    COUNT(p.id) AS products_count
FROM categories c
JOIN products p
    ON c.id = p.category_id
WHERE p.is_active = TRUE
GROUP BY c.id, c.name
ORDER BY products_count DESC
LIMIT 1;


-- 52
SELECT
    c.name AS customer_name,
    SUM(si.total_amount) AS total_purchases
FROM customers c
JOIN sales_invoices si
    ON c.id = si.customer_id
WHERE si.total_amount > 0
GROUP BY c.id, c.name
ORDER BY total_purchases DESC
LIMIT 1;


-- 53
SELECT
    s.name AS supplier_name,
    SUM(pi.total_amount) AS total_purchases
FROM suppliers s
JOIN purchase_invoices pi
    ON s.id = pi.supplier_id
WHERE pi.total_amount > 0
GROUP BY s.id, s.name
ORDER BY total_purchases DESC
LIMIT 1;


-- 54
SELECT
    SUM(total_amount) AS total_sales
FROM sales_invoices
WHERE invoice_date >= '2026-09-14'
  AND invoice_date < '2026-09-15';


-- 55
SELECT
    SUM(total_amount) AS total_sales
FROM sales_invoices
WHERE invoice_date >= '2026-09-10'
  AND invoice_date < '2026-09-15';


-- 56
SELECT DISTINCT
    p.name AS product_name,
    p.sale_price AS current_sale_price,
    sai.sale_price AS old_sale_price
FROM products p
JOIN sale_items sai
    ON p.id = sai.product_id
WHERE p.sale_price <> sai.sale_price
ORDER BY p.name;


-- 57
SELECT
    invoice_number,
    invoice_date,
    total_amount,
    paid_amount,
    remaining_amount
FROM sales_invoices
WHERE remaining_amount > 0
ORDER BY remaining_amount DESC;


-- 58
SELECT
    invoice_number,
    total_amount,
    paid_amount,
    remaining_amount
FROM sales_invoices
WHERE paid_amount < total_amount
  AND remaining_amount > 0
ORDER BY remaining_amount DESC;


-- 59
SELECT
    p.id,
    p.name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM purchase_items pri
    WHERE pri.product_id = p.id
)
AND NOT EXISTS (
    SELECT 1
    FROM sale_items sai
    WHERE sai.product_id = p.id
)
ORDER BY p.name;


-- 60
SELECT
    p.id,
    p.name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM sale_items sai
    WHERE sai.product_id = p.id
)
AND NOT EXISTS (
    SELECT 1
    FROM purchase_items pri
    WHERE pri.product_id = p.id
)
ORDER BY p.name;
