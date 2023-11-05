SELECT
    s.store_type,
    SUM(o.product_quantity * p.sale_price) AS total_sales,
    COUNT(o.order_date) AS order_count,
    (SUM(o.product_quantity * p.sale_price) / (SELECT SUM(o.product_quantity * p.sale_price) FROM orders o JOIN dim_product p ON o.product_code = p.product_code)) * 100 AS percentage_of_total_sales
FROM dim_store s
JOIN orders o ON s.store_code = o.store_code
JOIN dim_product p ON o.product_code = p.product_code
GROUP BY s.store_type;