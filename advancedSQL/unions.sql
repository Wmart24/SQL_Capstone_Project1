/*
opposite of joins, 
joins are used in the case whenever we want to combine tables
that relate on a single value.
While unions combine the result sets of two or more SELECT 
statements into a single result set.
*/

-- Get jobs and companies from January
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	jan_2023

UNION -- combine the two tables 

-- Get jobs and companies from February 
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	feb_2023

UNION -- combine another table

-- Get jobs and companies from March
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	mar_2023
--------------------------------------------
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	jan_2023

UNION ALL-- combine the two tables 

-- Get jobs and companies from February 
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	feb_2023

UNION ALL -- combine another table

-- Get jobs and companies from March
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	mar_2023


/*
Create a unified query that categorizes job postings into two groups: those with salary information 
(salary_year_avg or salary_hour_avg is not null) and those without it. Each job posting should be
listed with its job_id, job_title, and an indicator of whether salary information is provided.
*/

SELECT
    job_id,
    job_title,
    salary_year_avg,
    'Without salary info' AS salary_info
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NULL

UNION ALL 

SELECT
    job_id,
    job_title,
    salary_year_avg,
    'With salary info' AS salary_info
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL

-- given answer:
-- Select job postings with salary information
(
    SELECT 
        job_id, 
        job_title, 
        'With Salary Info' AS salary_info  -- Custom field indicating salary info presence
    FROM 
        job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL  
)
UNION ALL
 -- Select job postings without salary information
(
    SELECT 
        job_id, 
        job_title, 
        'Without Salary Info' AS salary_info  -- Custom field indicating absence of salary info
    FROM 
        job_postings_fact
    WHERE 
        salary_year_avg IS NULL AND salary_hour_avg IS NULL 
)
ORDER BY 
	salary_info DESC, 
	job_id; 

/*
Retrieve the job id, job title short, job location, job via, skill and skill type 
for each job posting from the first quarter (January to March). Using a subquery to 
combine job postings from the first quarter (these tables were created in the
 Advanced Section - Practice Problem 6 [include timestamp of Youtube video]) Only 
 include postings with an average yearly salary greater than $70,000.
*/

SELECT 
    job_id,
	job_title_short,
	job_location,
    job_via
FROM
	jan_2023

UNION ALL-- combine the two tables 

-- Get jobs and companies from February 
SELECT 
	job_id,
	job_title_short,
	job_location,
    job_via
FROM
	feb_2023

UNION ALL -- combine another table

-- Get jobs and companies from March
SELECT 
	job_id,
	job_title_short,
	job_location,
    job_via
FROM
	mar_2023
WHERE
    EXTRACT(QUARTER FROM job_posted_date) = 1

-- given answer:
SELECT
    job_postings_q1.job_id,
    job_postings_q1.job_title_short,
    job_postings_q1.job_location,
    job_postings_q1.job_via,
    job_postings_q1.salary_year_avg,
    skills_dim.skills,
    skills_dim.type
FROM
-- Get job postings from the first quarter of 2023
    (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
				UNION ALL
				SELECT *
				FROM march_jobs
    ) as job_postings_q1
LEFT JOIN skills_job_dim ON job_postings_q1.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_q1.salary_year_avg > 70000
ORDER BY
	job_postings_q1.job_id;