/*
Question: What are the available entry level/junior data analyst or data science jobs or internships?
- Identify the entry level/junior data analyst or data science jobs or internships roles 
that are available in New York, Florida, or remotely.
- Focuses on job postings with specified salaries (keeping nulls because there are not enough job postings with a salary for this query)
- Why? Highlight the top opportunities for roles that cater to me, offering insights into employment
*/

-- for data analysis
SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    ROUND(salary_year_avg, 2) AS salary,
    job_posted_date
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
    (job_title ILIKE '%Data Analyst intern%' 
    OR job_title ILIKE '%Entry level Data Analyst%' 
    OR job_title ILIKE '%Junior Data Analyst%')
    AND (job_location ILIKE '%New York%' 
    OR job_location ILIKE '%Florida%' 
    OR job_location ILIKE '%Anywhere%%')
ORDER BY
    salary_year_avg 

-- for data science
SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    ROUND(salary_year_avg, 2) AS salary,
    job_posted_date
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
    (job_title ILIKE '%Data Science intern%' 
    OR job_title ILIKE '%Entry level Data Scien%' 
    OR job_title ILIKE '%Junior Data Scien%')
    AND (job_location ILIKE '%New York%' 
    OR job_location ILIKE '%Florida%' 
    OR job_location ILIKE '%Anywhere%%')
ORDER BY
    salary_year_avg 

