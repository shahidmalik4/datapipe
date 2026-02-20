{{ config(materialized='table') }}

SELECT
    product_id AS product_key,
    product_name,
    category,
    brand,
    price,
    cost,
    (price - cost) AS margin,
    is_active,
    created_at,
    updated_at
FROM {{ ref('stg_products') }}