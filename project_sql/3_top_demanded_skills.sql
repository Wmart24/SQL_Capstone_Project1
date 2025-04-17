/*
Question: What are the most in demand skills for entry/junior/intern level data analysts/scientists?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in demand skills for the roles suited for me.
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for the job seekers.
*/

-- for data analyst
SELECT 
    skills,
	COUNT(sjd.job_id) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
	(job_title ILIKE '%Data Analyst intern%' 
        OR job_title ILIKE '%Entry level Data Analyst%' 
        OR job_title ILIKE '%Junior Data Analyst%')
        AND (job_location ILIKE '%New York%' 
        OR job_location ILIKE '%Florida%' 
        OR job_location ILIKE '%Anywhere%%')
GROUP BY
	skills
ORDER BY
	demand_count DESC
LIMIT 5

-- for data science
SELECT 
    skills,
	COUNT(sjd.job_id) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
	(job_title ILIKE '%Data Science intern%' 
	OR job_title ILIKE '%Entry level Data Scien%' 
	OR job_title ILIKE '%Junior Data Scien%')
	AND (job_location ILIKE '%New York%' 
	OR job_location ILIKE '%Florida%' 
	OR job_location ILIKE '%Anywhere%%')
GROUP BY
	skills
ORDER BY
	demand_count DESC
LIMIT 5
