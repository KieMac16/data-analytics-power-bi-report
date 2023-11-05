SELECT s.store_type AS german_store_type,
       SUM(o.product_quantity * p.sale_price) AS total_revenue
FROM orders o
JOIN dim_store s ON o.store_code = s.store_code
JOIN dim_product p ON o.product_code = p.product_code
WHERE EXTRACT(YEAR FROM o.order_date::date) = 2022
      AND s.country_code = 'DE'
GROUP BY german_store_type
ORDER BY total_revenue DESC
LIMIT 1;