-- Bucket Salaries
-- < 25 = 'Low'
-- 25-50 = 'Medium'
-- > 50 = 'High'

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
LIMIT 10;

-- Categorizing Categorical Values
-- Classify the 'job_title' column values as: 
    -- 'Data Analyst'
    -- 'Data Engineer'
    -- 'Data Scientist'

SELECT 
    job_title,
    job_title_short
FROM job_postings_fact
ORDER BY RANDOM()
LIMT 20;

-- Final Example: Conditional Calculations
-- Compute a standarized_salary using yearly salary and adjusted hourly salary
-- Categorize salaries into tiers of: 
    -- < 75k 'Low'
    -- 75k - 150k 'Medium'
    -- >= 150k 'High'
WITH salaries AS (
    SELECT
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
        END AS standarized_salary
    FROM 
        job_postings_fact
)

SELECT
    *,
    CASE
        WHEN standarized_salary IS NULL THEN 'Missing'
        WHEN standarized_salary < 75_00 THEN 'Low'
        WHEN standarized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM salaries
ORDER BY standarized_salary DESC
LIMIT 10;