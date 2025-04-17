/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for entry/junior/intern level data analysts/scientists
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for entry/junior/intern level data analysts/scientists and 
helps identify the most financially rewarding skills to acquire or improve
*/

-- for data analyst
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
	(job_title ILIKE '%Data Analyst intern%' 
        OR job_title ILIKE '%Entry level Data Analyst%' 
        OR job_title ILIKE '%Junior Data Analyst%')
    AND salary_year_avg IS NOT NULL
GROUP BY
	skills
ORDER BY
	avg_salary DESC
LIMIT 30

/*
	•	🔧 Top-paying entry-level roles often blend data analytics with software engineering and machine learning skills. Tools like Docker, Jenkins, Java, Spring, and TensorFlow top the list with average salaries around $103K. This indicates that employers are rewarding junior analysts who bring cross-functional abilities in DevOps, backend development, or AI engineering—areas typically outside the standard analyst toolkit.
	•	📊 Foundational data analytics tools such as SQL, Python, and R remain essential but offer more moderate pay unless paired with specialized expertise. These skills fall within the $65K–$67K range, showing that while they are in high demand, their widespread availability tempers the salary premium. Analysts looking to boost pay may need to layer these skills with cloud tools, machine learning, or software development experience.
	•	🤝 Soft tools that support collaboration, reporting, and enterprise workflows also appear in higher-paying job listings. Platforms like Jira, Confluence, PowerPoint, and SharePoint are associated with roles averaging $73K–$80K. This suggests that communication, documentation, and cross-team collaboration are seen as valuable traits even in technical roles—especially in larger or client-facing environments.
*/

-- for data science
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
	(job_title ILIKE '%Data Science intern%' 
	OR job_title ILIKE '%Entry level Data Scien%' 
	OR job_title ILIKE '%Junior Data Scien%')
    AND salary_year_avg IS NOT NULL
GROUP BY
	skills
ORDER BY
	avg_salary DESC
LIMIT 30

/*
💡 Top-Paying Skill Trends for Entry-Level Data Scientists (2023)
	•	🏗️ Big data engineering & orchestration skills top the salary charts. Tools like Hadoop ($115K), Airflow ($105K), Kafka, and Spark are strongly associated with higher-paying roles. These suggest that early-career data scientists who bring data pipeline, distributed computing, and workflow orchestration expertise are positioned for higher compensation—blurring the line between data science and data engineering.
	•	🛠️ Less common but highly technical languages and tools boost pay significantly. Skills like Perl, Scala, and Neo4j (graph databases) command six-figure salaries, reflecting either niche expertise or demand for rare capabilities in specialized applications like natural language processing, legacy systems, or advanced network analysis.
	•	☁️ Cloud, backend, and infrastructure tools round out high-paying entry-level profiles. Familiarity with AWS, Linux, Java, Spring, Chef, and GitHub/GitLab are tied to roles averaging $85K–$95K. These skills suggest that even junior data scientists are expected to engage with production environments, deployment pipelines, or CI/CD systems, especially in more tech-focused companies.
*/