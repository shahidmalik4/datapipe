WITH ranked_orders AS (
    SELECT
        order_id,
        order_item_id,
        customer_id,
        product_id,
        quantity,
        unit_price,
        discount_amount,
        order_status,
        payment_method,
        (quantity * unit_price - discount_amount) AS total_price,
        order_timestamp::timestamp AS order_ts,
        shipping_timestamp::timestamp AS shipping_ts,
        created_at::timestamp AS created_ts,
        updated_at::timestamp AS update_ts,
        ROW_NUMBER() OVER (
            PARTITION BY order_id, order_item_id 
            ORDER BY updated_at DESC
        ) AS rn
    FROM {{ source('raw', 'raw_orders') }}
)
SELECT *
FROM ranked_orders
WHERE rn = 1
    AND order_id IS NOT NULL
    AND order_item_id IS NOT NULL
