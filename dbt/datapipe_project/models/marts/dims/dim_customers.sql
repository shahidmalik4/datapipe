{{ config(materialized='table') }}

SELECT
    customer_id AS customer_key,
    first_name,
    last_name,
    email,
    city,
    country,
    signup_date,
    market_segment,
    is_active,
    last_updated
FROM {{ ref('stg_customers') }}