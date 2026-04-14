-- Array Intro
SELECT ['python, 'sql', 'r'] AS skills_array;

WITH skills AS (
    SELECT 'python' AS skills
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
)
SELECT ARRAY_AGG(skill) AS skills_array
FROM skills;

-- Struct
SELECT {skill: 'Python', type: 'programming'} AS skill_struct;

-- Array - Final Example
-- Build a flat skill table for co-workers to access job titles, salary info, and skills in one table

CREATE OR REPLACE TEMP TABLE job_skills_array AS 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills_array
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sd.skill_id = sjd.skill_id
GROUP BY ALL;

-- From the perspective of a Data Analyst, analyze the median salary per skill
WITH skills As (
    SELECT 'python' AS skill
    UNION ALL 
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skills_array AS (
    SELECT ARRAY_AGG(skill) AS skills
    FROM skills
)
SELECT
    skills
FROM skills_array;