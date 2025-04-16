/*
Find the average salary both yearly (salary_year_avg) and 
hourly (salary_hour_avg) for job postings using the job_postings_fact table
 that were posted after June 1, 2023. Group the results by job schedule type. 
Order by the job_schedule_type in ascending order.
*/

SELECT 
    job_schedule_type,
    ROUND(AVG(salary_year_avg), 2) AS avg_yearly_sal,
    ROUND(AVG(salary_hour_avg), 2) AS avg_hour_sal
FROM   
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type

/*
Count the number of job postings for each month in 2023, 
adjusting the job_posted_date to be in
 'America/New_York' time zone before extracting the month.
 Assume the job_posted_date is stored in UTC. 
Group by and order by the month.
*/

SELECT
    COUNT(job_id) AS job_count, 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS months
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP by
    months
ORDER by
    months

/*
 EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS months
this is important because without mentioning AT TIME ZONE 'UTC'
then the results differ slightly,
so when a problem says assume the data is stored in UTC then this is what has to be done.
*/


/*
Find companies (include company name) that have posted jobs 
offering health insurance,
where these postings were made in the 
second quarter of 2023. 
Use date extraction to filter by quarter. 
And order by the job postings count from highest to lowest.
*/

SELECT * FROM job_postings_fact LIMIT 10;

SELECT * FROM company_dim


SELECT
    cd.name,
    COUNT(jpf.job_id) AS company_job_count
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
    job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM job_posted_date) = 2
GROUP BY
    cd.name
ORDER BY
    company_job_count DESC

-- here is the given answer:

SELECT
    company_dim.name AS company_name,
    COUNT(job_postings_fact.job_id) AS job_postings_count
FROM
    job_postings_fact
	INNER JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2 
GROUP BY
    company_dim.name 
HAVING
    COUNT(job_postings_fact.job_id) > 0
ORDER BY
	job_postings_count DESC; 

--results seem to be the same for the most part