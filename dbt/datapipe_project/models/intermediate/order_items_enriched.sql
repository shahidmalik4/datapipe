-- models/intermediate/order_items_enriched.sql
SELECT
    o.order_id,
    o.order_item_id,
    o.customer_id,
    o.product_id,
    p.product_name,
    p.category AS product_category,
    o.quantity,
    o.unit_price,
    o.discount_amount,
    o.total_price AS line_total,
    o.order_status,
    o.payment_method,
    o.order_ts,
    o.shipping_ts
FROM {{ ref('orders') }} o
LEFT JOIN {{ ref('products') }} p
    ON o.product_id = p.product_id
