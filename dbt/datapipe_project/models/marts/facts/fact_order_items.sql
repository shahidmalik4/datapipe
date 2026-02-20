{{ config(materialized='table') }}

SELECT
    o.order_id,
    o.order_item_id AS order_item_key,
    o.customer_id   AS customer_key,
    o.product_id    AS product_key,

    o.quantity,
    o.unit_price,
    o.discount_amount,
    o.total_price,

    o.order_status,
    o.payment_method,

    o.order_ts,
    o.shipping_ts,
    o.created_ts,
    o.update_ts

FROM {{ ref('stg_orders') }} o