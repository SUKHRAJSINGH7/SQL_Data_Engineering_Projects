-- Partition By - Find hourly salary
SELECT 
    job_id,
    job_title_short,   
    salary_hour_avg,
    AVG(salary_hour_avg) OVER ()
FROM
    job_postings_fact;