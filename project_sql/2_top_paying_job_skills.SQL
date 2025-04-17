/*
Question: What skills are required for the entry level data analyst or data science jobs or internships?
- Use the top 10 highest paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high paying jobs demand certain skills, 
helping job seekers understand which skills to develop that align with top salaries
*/

-- for data analysis
WITH top_paying_jobs AS (
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
)
SELECT 
    top_paying_jobs.*,
    sd.skills 
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim AS sjd ON top_paying_jobs.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
ORDER BY
    salary 
/*
Skill Frequency Insights for Data Analytics Roles (2023)

An analysis of job postings from 2023 for entry-level and internship data analytics roles reveals the following key skill trends:
	•	SQL emerged as the most sought-after skill, underscoring its critical role in querying and managing structured data—a foundational task in analytics.
	•	Python followed closely, highlighting its versatility for data cleaning, analysis, automation, and lightweight modeling tasks.
	•	Excel remains a core tool, especially valued in business environments for reporting and quick data manipulation, often used in conjunction with other tools.
	•	Tableau and Power BI, both leading data visualization platforms, appeared frequently, emphasizing the importance of presenting data insights clearly to stakeholders.
	•	R was also present, albeit to a lesser extent than Python, suggesting a more niche or statistical-heavy role in some positions.
	•	Soft tools like PowerPoint indicate an expectation that analysts will present their findings effectively in business-friendly formats.
	•	Other notable skills include data analysis, problem-solving, and communication, which point toward analytical thinking, business acumen, and collaboration as essential traits.
	•	Tools like Jupyter, Git, Looker, Snowflake, and Google Sheets also made appearances, showing that many employers value familiarity with a range of modern cloud-based and collaborative data environments.

Overall, the demand reflects a balance of technical proficiency, communication skills, and business context understanding—qualities that define an effective data analyst in today’s workforce.
*/

-- for data science
WITH top_paying_jobs AS (
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
)
SELECT 
    top_paying_jobs.*,
    sd.skills 
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim AS sjd ON top_paying_jobs.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
ORDER BY
    salary 
/*
Skill Frequency Insights for Data Science Roles (2023)

The skill distribution across junior and internship-level data science roles in 2023 shows a clear emphasis on programming and modeling tools:
	•	Python dominates as the most requested skill, reinforcing its role as the primary programming language in the data science ecosystem—used for everything from data cleaning to machine learning.
	•	SQL follows closely, showing that data scientists are often expected to retrieve and manipulate structured data from databases.
	•	Machine Learning, data analysis, and statistics also rank high, highlighting the core analytical and modeling responsibilities expected of data scientists.
	•	R remains a valued skill, particularly in roles with a focus on statistical modeling or academic-style analysis.
	•	Jupyter and Git suggest that employers value workflow management, version control, and the use of notebooks for interactive analysis and reproducibility.
	•	Data visualization tools like Tableau and Power BI, while less frequent than in analytics roles, still appear—indicating a growing expectation for data scientists to communicate insights effectively.
	•	Deep learning, TensorFlow, PyTorch, and scikit-learn reflect increasing demand for machine learning and AI-focused capabilities.
	•	Other soft tools like Excel and PowerPoint make occasional appearances, typically for roles that blend data science with stakeholder communication or business decision-making.

This skill landscape suggests that successful entry-level data scientists need a strong foundation in programming, statistics, and machine learning, while also being comfortable working with databases, collaborating via Git, and communicating findings clearly.
*/
