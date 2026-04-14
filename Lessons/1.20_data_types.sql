SELECT
    job_id,
    job_work_from_home,
    job_posted_data,
    salary_year_avg

FROM 
    job_postings_fact 
LIMIT 10;


DESCRIBE 
SELECT
    job_title_short,
    salary_year_avg
FROM  
    job_postings_fact; 


SELECT CAST(123 AS VARCHAR);