-- Create Temp Table
CREATE OR REPLACE TEMP TABLE sec_priority_jobs AS 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.name AS company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    r.priority_1v1,
    CURRENT_TIMESTAMP AS updated_at
FROM 
    data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
INNER JOIN staging.priority_roles AS r
    ON jpf.job_title_short = r.role_name;

-- Update Statement
 UPDATE main.priority_1v1 AS tgt
 SET 
    priority_1v1 = src.priority_1v1,
    updated_at = src.updated_at 
FROM src_priority_jobs AS src
WHERE tgt.job_id = src.job_id
    AND tgt.priority_1v1 IS DISTINCT FROM src.priority_1v1;
-- Insert Statement
INSERT INTO main.priority_jobs_snapshot (
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_1v1,
    updated_at
);

SELECT 
    src.job_id,
    src.job_title_short,
    src.company_name,
    src.job_posted_date,
    src.priority_1v1,
    src.updated_at
FROM src_priority_jobs AS src
WHERE NOT EXISTS (
    SELECT 1
    FROM main.priority_jobs_snapshot AS tgt
    WHERE tgt.job_id = src.job_id 
);
-- Delete Statement
DELETE FROM main.priority_jobs_snapshot AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM src_priority_jobs as src
    WHERE src.job_id = tgt.job_id
);

SELECT
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_1v1) AS priority_1v1,
    Min(updated_at) AS updated_at
FROM priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;