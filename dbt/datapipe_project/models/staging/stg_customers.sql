SELECT
    customer_id,
    first_name,
    last_name,
    email,
    city,
    country,
    signup_date::date       AS signup_date,
    customer_segment        AS market_segment,
    is_active,
    updated_at::timestamp   AS last_updated
FROM {{ source('raw', 'raw_customers') }}
WHERE customer_id IS NOT NULL
