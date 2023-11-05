SELECT p.category, SUM(o.product_quantity * (p.sale_price - p.cost_price)) AS total_profit
FROM orders o
JOIN dim_store s ON o.store_code = s.store_code
JOIN dim_product p ON o.product_code = p.product_code
WHERE s.full_region = 'Wiltshire, UK' 
      AND EXTRACT(YEAR FROM o.order_date::date) = 2021
GROUP BY p.category
ORDER BY total_profit DESC
LIMIT 1;
