/*
- Find the count of the number of remote job postings per skill
    - Display the top 5 skills in descending order by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
    - Why? Identify the top 5 skills in demand for remote jobs
*/


SELECT
    sd.skill_id,
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM
    job_postings_fact AS jpf
LEFT JOIN
    skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_work_from_home = TRUE
GROUP BY
    sd.skill_id,
    sd.skills
ORDER BY
    job_count DESC
LIMIT 5

-- given answer: results are still the same though

-- Get the number of job postings per skill for remote jobs
WITH remote_job_skills AS (
  SELECT 
		skill_id, 
		COUNT(*) as skill_count
  FROM 
		skills_job_dim AS skills_to_job
	-- only get the relevant job postings
  INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
  WHERE 
		job_postings.job_work_from_home = True
		-- If you only want to search for data analyst jobs (like Luke does in the video)
		--job_postings.job_title_short = 'Data Analyst'
  GROUP BY 
		skill_id
)

-- Return the skill id, name, and count of how many times its asked for
SELECT 
	skills.skill_id, 
	skills as skill_name, 
	skill_count
FROM remote_job_skills
-- Get the skill name
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
	skill_count DESC
LIMIT 5;