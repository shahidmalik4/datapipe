SELECT
    product_id,
    product_name,
    category,
    brand,
    price,
    cost,
    is_active,
    created_at::date       AS created_at,
    updated_at::timestamp   AS updated_at
FROM {{ source('raw', 'raw_products') }}
WHERE product_id IS NOT NULL