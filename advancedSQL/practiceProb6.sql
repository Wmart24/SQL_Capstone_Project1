/*
**Question:** 
- Create three tables:
    - Jan 2023 jobs
    - Feb 2023 jobs
    - Mar 2023 jobs
- **Foreshadowing:** This will be used in another practice problem below.
- Hints:
    - Use `CREATE TABLE table_name AS` syntax to create your table
    - Look at a way to filter out only specific months (`EXTRACT`)
*/

CREATE TABLE Jan_2023 AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

CREATE TABLE Feb_2023 AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2
)

CREATE TABLE Mar_2023 AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
)

SELECT
    job_posted_date
FROM
    Jan_2023
