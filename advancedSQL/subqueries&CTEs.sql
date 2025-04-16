SELECT
    name 
FROM
    company_dim
WHERE 
    company_id IN (

        SELECT
            company_id
        FROM
            job_postings_fact
        WHERE
            job_no_degree_mention = TRUE
)
/*
this is basically saying, where the
company_id is within this table,
we only want to return those company names 
that are associated with it
*/

/*
Find the companies that have the most 
job postings.
- Get the total number of job postings 
per company_id
- Return the total number of jobs with
the company name
*/
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
    name,
    company_job_count.total_jobs
FROM
    company_dim AS cd 
LEFT JOIN
    company_job_count ON company_job_count.company_id = cd.company_id
ORDER BY
    total_jobs DESC
/*
Identify the top 5 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest counts in the skills_job_dim 
table and then join this result with the skills_dim table to get the skill names.
*/

SELECT
    sjd.skill_id,
    sd.skills,
    COUNT(sjd.skill_id) AS skill_count
FROM
    skills_job_dim AS sjd
LEFT JOIN
    skills_dim AS sd ON sjd.skill_id = sd.skill_id
GROUP BY
    sjd.skill_id,
    sd.skills
ORDER BY
    skill_count DESC
LIMIT 5


SELECT * FROM skills_dim


SELECT
    sd.skills
FROM 
    skills_dim AS sd
INNER JOIN (
     SELECT
            skill_id,
            COUNT(*) AS skill_job_count
        FROM
            skills_job_dim
        GROUP BY
            skill_id
        ORDER BY
            skill_job_count
        LIMIT 5
) AS tk ON sd.skill_id = tk.skill_id
ORDER BY
    tk.skill_job_count DESC

/*
Determine the size category ('Small', 'Medium', or 'Large') for each company by 
first identifying the number of job postings they have. Use a subquery to calculate 
the total job postings per company. A company is considered 'Small' if it has 
less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, 
and 'Large' if it has more than 50 job postings. Implement a subquery to aggregate job counts 
per company before classifying them based on size.
*/

SELECT
    CASE WHEN ( SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id) < 10 THEN 'small'
    CASE WHEN (   SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id) <= 50 THEN 'medium'
    CASE WHEN (   SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id) > 50 THEN 'large'
    END AS company_size
FROM
    job_postings_fact

-- given answer:
/*
Solution:
Select the company_id and name from the subquery alias company_info to 
retrieve the unique identifier and name of the company.
Use a CASE statement to categorize each company based on the number of job postings they have:
Label as 'Small' when the count of job postings (job_count) is less than 10.
Label as 'Medium' when the count is between 10 and 50.
Label as 'Large' when the count is more than 50.
Use a subquery to calculate the number of job postings per company:
Inside the subquery, SELECT the company_id and company_name, and 
calculate the count of job postings as job_count.
Use FROM to specify the company_dim table to pull company information.
Apply an INNER JOIN with the job_postings_fact table to match each 
job posting to its respective company.
GROUP BY company_id and name to ensure the count is accurate for each company.
Alias the subquery as company_info which will be used in the main SELECT 
statement for joining with the company details.
*/

SELECT 
	company_id,
  name,
	-- Categorize companies
  CASE
	  WHEN job_count < 10 THEN 'Small'
    WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
    ELSE 'Large'
  END AS company_size

FROM 
-- Subquery to calculate number of job postings per company 
(
  SELECT 
		company_dim.company_id, 
		company_dim.name, 
		COUNT(job_postings_fact.job_id) as job_count
  FROM 
		company_dim
  INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
  GROUP BY 
		company_dim.company_id, 
		company_dim.name
) AS company_job_count;

/*
Find companies that offer an average salary above the overall average yearly 
salary of all job postings. Use subqueries to select companies with an average salary
higher than the overall average salary (which is another subquery).
 */

SELECT
    ROUND(AVG(salary_year_avg), 2) AS avg_sal
FROM
    job_postings_fact

SELECT
    SUM(salary_year_avg) / COUNT(job_id)
FROM
    job_postings_fact
where
    salary_year_avg IS NOT NULL

-- given answer:
/*
Solution:

Select the company names (name) from the company_dim table to identify the companies.
INNER JOIN the company_dim table with a subquery:
selects the company_id and the average of salary_year_avg
from the job_postings_fact table,
grouping the results by company_id.
Name this subquery as company_salaries, which now holds the average salary information per company
JOIN on company_id
In the WHERE clause of your main query, include another subquery that:
In the SELECT calculates the overall average salary across all job postings 
(AVG(salary_year_avg)) from the job_postings_fact table.
Compare each company's average salary (company_salaries subquery) to the 
overall average salary determined by the second subquery; average salary is greater 
than this overall average.
*/

SELECT 
    company_dim.name
FROM 
    company_dim
INNER JOIN (
    -- Subquery to calculate average salary per company
    SELECT 
			company_id, 
			AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
    GROUP BY company_id
    ) AS company_salaries ON company_dim.company_id = company_salaries.company_id
-- Filter for companies with an average salary greater than the overall average
WHERE company_salaries.avg_salary > (
    -- Subquery to calculate the overall average salary
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
);

/*
Identify companies with the most diverse (unique) job titles. Use a CTE to count 
the number of unique job titles per company, then select companies with the highest 
diversity in job titles.
*/
WITH distinct_companies AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
    cd.name,
    unique_count
FROM
    company_dim AS cd
INNER join
    distinct_companies AS dc ON cd.company_id = dc.company_id
ORDER BY
    dc.unique_count DESC
LIMIT 10


-- given answer:
-- Define a CTE named title_diversity to calculate unique job titles per company
WITH title_diversity AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_titles  
    FROM job_postings_fact
    GROUP BY company_id  
)
-- Get company name and count of how many unique titles each company has
SELECT
    company_dim.name,  
    title_diversity.unique_titles  
FROM title_diversity
	INNER JOIN company_dim ON title_diversity.company_id = company_dim.company_id  
ORDER BY 
	unique_titles DESC  
LIMIT 10;

/*
Explore job postings by listing job id, job titles, company names, 
and their average salary rates, while categorizing these salaries relative 
to the average in their respective countries. Include the month of the job posted date.
Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages.
*/
WITH country_avg AS (
    SELECT
        job_country,
        AVG(salary_year_avg) AS avg_sal
    FROM
        job_postings_fact
    GROUP BY
        job_country
)
SELECT 
    jpf.job_id,
    jpf.job_title,
    jpf.salary_year_avg,
    ca.avg_sal,
    AVG(jpf.salary_year_avg),
    CASE WHEN AVG(jpf.salary_year_avg) > ca.avg_sal THEN 'Above average'
    ELSE 'below average'
    END AS salary_comparison
FROM
    country_avg AS ca 
INNER JOIN
    job_postings_fact AS jpf ON jpf.job_country = ca.job_country
GROUP BY
    job_id,
    job_title,
    jpf.salary_year_avg
    ca.avg_sal

-- given answer:
/*
Create Common Table Expression (CTE) named avg_salaries
Calculate the average yearly salary (AVG(salary_year_avg)) for each country (job_country)
From the job_postings_fact table,
Grouping the results by job_country.
In the main query:
Select:
the job_id, job_title, and company name (companies.name) to get the basic job posting information.
Retrieve the salary (salary_year_avg) for each job posting and label it as salary_rate.
Categorize each salary as 'Above Average' or 'Below Average' by comparing the 
individual salary rate to the average salary of the corresponding country obtained 
from the avg_salaries CTE (job_postings.salary_year_avg > avg_salaries.avg_salary)
Extract the month from the job posting date (job_posted_date) to include in your results as posting_month.
INNER JOIN the job_postings_fact table with the company_dim table to link each 
job posting with the respective company name.
INNER JOIN the avg_salaries CTE to bring in the average salary data for comparison.
Order the results by the posting_month in descending order to sort the job postings 
starting with the most recent.
*/
-- gets average job salary for each country
WITH avg_salaries AS (
  SELECT 
    job_country, 
    AVG(salary_year_avg) AS avg_salary
  FROM job_postings_fact
  GROUP BY job_country
)

SELECT
  -- Gets basic job info
	job_postings.job_id,
  job_postings.job_title,
  companies.name AS company_name,
  job_postings.salary_year_avg AS salary_rate,
-- categorizes the salary as above or below average the average salary for the country
  CASE
    WHEN job_postings.salary_year_avg > avg_salaries.avg_salary
    THEN 'Above Average'
    ELSE 'Below Average'
  END AS salary_category,
  -- gets the month and year of the job posting date
  EXTRACT(MONTH FROM job_postings.job_posted_date) AS posting_month
FROM
  job_postings_fact as job_postings
INNER JOIN
  company_dim as companies ON job_postings.company_id = companies.company_id
INNER JOIN
  avg_salaries ON job_postings.job_country = avg_salaries.job_country
ORDER BY
    -- Sorts it by the most recent job postings
    posting_month desc

