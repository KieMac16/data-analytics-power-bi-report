SELECT EXTRACT(MONTH FROM o.order_date::date) AS month,
       SUM(o.product_quantity * p.sale_price) AS total_revenue
FROM orders o
JOIN dim_product p ON o.product_code = p.product_code
WHERE EXTRACT(YEAR FROM o.order_date::date) = 2022
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 1;