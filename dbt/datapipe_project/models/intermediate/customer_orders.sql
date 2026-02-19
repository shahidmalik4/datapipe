WITH orders_summary AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(total_price) AS total_spent,
        MAX(order_ts) AS last_order_date
    FROM {{ ref('orders') }}
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.country,
    c.signup_date,
    c.market_segment,
    c.is_active,
    o.total_orders,
    o.total_spent,
    o.last_order_date
FROM {{ ref('customers') }} c
LEFT JOIN orders_summary o
    ON c.customer_id = o.customer_id
