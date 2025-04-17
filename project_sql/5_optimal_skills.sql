/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high paying skill)?
- Identify skills in high demand and associated with high average salaries for entry/junior/intern level data analysts/scientists
- Concentrates on remote positions along with positions based in New York or Florida with specified salaries 
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis and data science
*/

WITH skills_demand AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM
        job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
    WHERE 
        (job_title ILIKE '%Data Analyst intern%' OR job_title ILIKE '%Data Science intern%' 
        OR job_title ILIKE '%Entry level Data Analyst%' OR job_title ILIKE '%Entry level Data Science%')
        AND (job_location ILIKE '%New York%' OR job_location ILIKE '%Florida%' OR job_location ILIKE '%Anywhere%%')
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id
), average_salary AS (
    SELECT 
        sjd.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM
        job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
    WHERE 
        (job_title ILIKE '%Data Analyst intern%' OR job_title ILIKE '%Data Science intern%' 
        OR job_title ILIKE '%Entry level Data Analyst%' OR job_title ILIKE '%Entry level Data Science%')
        AND salary_year_avg IS NOT NULL
        -- AND (job_location ILIKE '%New York%' OR job_location ILIKE '%Florida%' OR job_location ILIKE '%Anywhere%%')
    GROUP BY
        sjd.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
--WHERE
    --demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC

-- rewriting the same query more concisely
-- for data analysis
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary
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
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) > 2
ORDER BY
    avg_salary DESC,
    demand_count DESC

-- for data science
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary
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
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) > 2
ORDER BY
    avg_salary DESC,
    demand_count DESC
