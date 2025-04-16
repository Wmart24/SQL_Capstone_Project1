/*
I only want to look at job postings from the first quarter that have a salary greater than $70k. 

- ⚠️ Note:
    - Alias is necessary because it will return an error without it. It’s needed for subqueries in the FROM clause.
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000 from the first quarter of 2023 (Jan-Mar)
- Why? Look at job postings for the first quarter of 2023 (Jan-Mar) that has a salary > $70,000
*/

--always create subquery first, then build off of that
SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT 
        *
    FROM jan_2023
    UNION ALL
    SELECT
        *
    FROM feb_2023
    UNION ALL
    SELECT
        *
    FROM mar_2023
) AS q1_job_postings
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC