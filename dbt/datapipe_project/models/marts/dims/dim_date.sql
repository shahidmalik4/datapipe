{{ config(materialized='table') }}

WITH date_spine AS (

    -- Generate dates from 2020 to 2030
    SELECT 
        d::date AS full_date
    FROM generate_series(
        '2020-01-01'::date,
        '2030-12-31'::date,
        interval '1 day'
    ) AS d

)

SELECT
    -- Surrogate key
    TO_CHAR(full_date, 'YYYYMMDD')::int         AS date_key,

    full_date                                   AS date,

    -- Calendar attributes
    EXTRACT(YEAR FROM full_date)                AS year,
    EXTRACT(MONTH FROM full_date)               AS month,
    TO_CHAR(full_date, 'Month')                 AS month_name,
    TO_CHAR(full_date, 'Mon')                   AS month_short,
    EXTRACT(DAY FROM full_date)                 AS day,
    EXTRACT(DOW FROM full_date)                 AS day_of_week,
    TO_CHAR(full_date, 'Day')                   AS day_name,
    TO_CHAR(full_date, 'Dy')                    AS day_short,
    EXTRACT(DOY FROM full_date)                 AS day_of_year,
    EXTRACT(WEEK FROM full_date)                AS week_of_year,
    EXTRACT(QUARTER FROM full_date)             AS quarter,

    -- Flags
    CASE WHEN EXTRACT(DOW FROM full_date) IN (0,6)
         THEN true ELSE false END               AS is_weekend,

    CASE WHEN full_date = CURRENT_DATE
         THEN true ELSE false END               AS is_today,

    -- Period boundaries
    DATE_TRUNC('month', full_date)::date        AS month_start_date,
    (DATE_TRUNC('month', full_date) + interval '1 month - 1 day')::date 
                                                AS month_end_date,

    DATE_TRUNC('quarter', full_date)::date      AS quarter_start_date,
    (DATE_TRUNC('quarter', full_date) + interval '3 month - 1 day')::date
                                                AS quarter_end_date,

    DATE_TRUNC('year', full_date)::date         AS year_start_date,
    (DATE_TRUNC('year', full_date) + interval '1 year - 1 day')::date
                                                AS year_end_date

FROM date_spine