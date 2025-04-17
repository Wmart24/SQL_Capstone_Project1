# Introduction
📊 Dive into the data job market! Focusing on entry/junior level data analyst/scientist roles along with internships,
this project explores 💰 top paying jobs, 🔥 in demand skills, and 📈 where high demand meets high salary in these roles.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Determined and passionate about learning about data and improving my SQL skills in order to land my first internship or my first job in the data world, I sought out different articles, and videos. I came across a youtube video teaching SQL that contained this dataset, a dataset that allows me to explore and navigate the 2023 data analyst/scientist job market more effectively. The data was obtained from Luke Barousse's [SQL course](https://www.lukebarousse.com/sql), containing insights on job titles, salaries, locations, and essential skills.

### The questions I answered through my SQL queries were:

1. What are the available entry level/junior data analyst/science jobs or internships?
2. What skills are required for the entry level data analyst/science jobs or internships?
3. What are the most in demand skills for entry/junior/intern level data analysts/scientists?
4. What are the top skills based on salary?
5. What are the most optimal skills to learn (aka it's in high demand and a high paying skill)?

# Tools I used
To explore the data job market, I made use of several important tools:

- **SQL**: This served as the foundation of my analysis, enabling me to query the database and extract valuable insights.
- **PostgreSQL**: The chosen database management systme, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data job market. Here's how I approached each question: 

### 1. Available entry level/junior data analyst/science jobs or internships
To identify the available roles I created two queries, one for data analyst and the other for data scientist positions, filtering them by average yearly salary and location, focusing on remote jobs along with those based in New York or Florida. This query highlights the available opportunities in the field.

```sql
-- for data analysis
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
```

Here's the breakdown of the available entry/junior level data analyst roles and internships in 2023:
- Junior and entry-level data analyst roles in 2023 were dominated by remote opportunities, with “Anywhere” being the most frequent job location. Major cities like New York, Chicago, and Los Angeles also remained top destinations, showing a healthy mix of remote and in-person demand.
- A small number of companies, such as Get It Recruit and DonorSearch, accounted for a significant portion of job listings, often posting repetitive titles like “Junior Data Analyst” or “Entry-Level Data Analyst.” This suggests that many roles are posted at scale or involve recurring openings.
- Most salaries for these roles fall between $40,000 and $70,000, with only a few breaking into six figures. Higher-paying roles are likely tied to technical specializations or companies in high-cost areas, while the average reflects typical entry-level compensation.
- The most common job titles include variations of “Junior” and “Entry-Level Data Analyst,” indicating a heavy focus on foundational skills and generalist responsibilities in data preparation, reporting, and dashboarding.
- Hiring activity was consistent throughout the year, with peaks in January, May, and September, hinting at seasonal trends such as internship recruitment, fiscal planning cycles, or post-graduation hiring waves.
![Available DA Roles](https://github.com/user-attachments/assets/47f880ec-3442-484e-abe0-4a303f643572)
*A multi-panel visualization highlighting the top hiring companies, most common job titles, leading job locations, and the salary distribution for entry-level and internship data analyst roles in 2023; ChatGPT generated this graph from my SQL query results*

```sql
-- for data science
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
```

Here's the breakdown of the available entry/junior level data scientist roles and internships in 2023:
- Remote roles dominate the early-career data science space, with “Anywhere” leading as the top job location, suggesting flexibility and wide geographic reach for candidates.
- DonorSearch and a handful of tech-forward companies posted the majority of listings, often using “Junior Data Scientist” and “Intern” titles, indicating standardized role offerings for fresh talent.
- Salaries mostly range from $55K to $75K, with higher-paying roles tied to advanced technical requirements such as machine learning, cloud computing, or big data infrastructure.
- Job titles were heavily skewed toward foundational, entry-level roles, emphasizing core data science skills like modeling, scripting, and basic statistical inference.
- Hiring remained steady across all months, showing that entry-level data science recruitment isn’t tightly tied to specific seasonal cycles, unlike internships or summer roles.
  ![Available DS Roles](https://github.com/user-attachments/assets/8928b4b9-934b-40a9-8dc5-14d6ed7fe70f)
*A multi-panel visualization highlighting the key hiring patterns for entry-level data science positions, including top employers, frequently used job titles, and a breakdown of salary distribution across postings from 2023; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Available Jobs
To understand what skills are required for the available jobs, I joined the job postings with the skills data, providing insights into what employers value for these roles.

```sql
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
```

Here's the breakdown of the most demanded skills for the available entry/junior level data analyst jobs and internships in 2023:
- Technical tools like SQL, Python, and Excel are foundational for data analyst roles, with SQL leading in demand for structured data querying, and Python recognized for its flexibility in cleaning, automation, and basic modeling tasks. Excel remains widely used for quick, business-oriented analysis.
- Data visualization and reporting skills are highly valued, with frequent mentions of Tableau, Power BI, and even PowerPoint—highlighting the importance of clearly communicating insights to stakeholders in both technical and business-friendly formats.
- A well-rounded data analyst is expected to combine technical proficiency with business awareness and collaboration, as shown by the appearance of tools like Git, Jupyter, Snowflake, and Google Sheets, alongside soft skills like communication and problem-solving.
![2_top_10_skills_DA](https://github.com/user-attachments/assets/2f94d0a4-a1d1-4aaf-b5eb-a4a814a22bb5)
* Bar graph visualization the count of skills for entry-level and internship data analyst roles in 2023; ChatGPT generated this graph from my SQL query results*

```sql
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
```
Here's the breakdown of the most demanded skills for the available entry/junior level data science jobs and internships in 2023:
- Python and SQL are the core technical foundations for entry-level data scientists, widely used for data cleaning, querying, analysis, and machine learning. These languages dominate job postings and form the base of most data workflows.
- Analytical and modeling skills such as machine learning, statistics, and data analysis are highly emphasized, along with tools like scikit-learn, TensorFlow, and R—especially in roles focused on predictive modeling, academic analysis, or AI.
- Collaboration and communication tools like Git, Jupyter, Tableau, and PowerPoint also appear, showing that employers value not only technical fluency but also the ability to present findings and work within reproducible, team-driven environments.
![2_top_10_skills_DS](https://github.com/user-attachments/assets/27cff3d1-3f57-4a2d-8cb6-361842cc35c5)
* Bar graph visualization the count of skills for entry-level and internship data science roles in 2023; ChatGPT generated this graph from my SQL query results*

### 3. In Demand Skills for Entry/Junior level roles and internships
This query helped indentify the skills most frequently requested in job postings, directing focus to areas with high demand

```sql
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
GROUP BY
	skills
ORDER BY
	demand_count DESC
LIMIT 5
```

Here's the breakdown of the most demanded skills for entry/junior level data analyst jobs and internships in 2023:
- SQL and Excel top the list of most in-demand skills, with over 2,500 mentions each—underscoring their continued dominance in entry-level data analyst roles for tasks like querying databases, building reports, and performing quick analyses.
- Python stands out as a key differentiator, showing strong demand across nearly 2,000 postings. Its presence reflects the increasing need for analysts who can automate workflows, clean data efficiently, and perform basic statistical modeling.
- Visualization tools like Tableau and Power BI are essential for storytelling with data, appearing in over 1,000 postings each. These tools enable early-career analysts to present findings clearly, making them highly valuable for stakeholder communication and business impact.
  
| Skill     | Demand Count |
|-----------|--------------|
| SQL       | 2,627        |
| Excel     | 2,513        |
| Python    | 1,980        |
| Tableau   | 1,407        |
| Power BI  | 1,171        |

*Table of the demand for the top 5 skills for entry/junior level data analyst jobs and internships*

```sql
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
GROUP BY
	skills
ORDER BY
	demand_count DESC
LIMIT 5
```
Here's the breakdown of the most demanded skills for entry/junior level data science jobs and internships in 2023:
- Python is by far the most dominant skill, appearing in over 3,600 job postings—nearly double the demand of any other skill. This reinforces Python’s position as the core language for data science, powering everything from data preprocessing and analysis to machine learning and deep learning.
- SQL remains essential, with close to 2,000 mentions, highlighting its importance in querying structured data and integrating with production databases—often forming the bridge between data science and data engineering tasks.
- R and SAS are still in demand, especially in roles involving statistical modeling or legacy systems. While not as widely used as Python, they remain critical in specific industries like healthcare, finance, and research-heavy sectors.
- Visualization tools like Tableau also appear in the top ranks, with nearly 1,000 mentions. This shows that communication of findings and data storytelling is a valued part of a junior data scientist’s skillset.

| Skill   | Demand Count |
|---------|--------------|
| Python  | 3,670        |
| SQL     | 1,935        |
| R       | 1,585        |
| Tableau |   981        |
| SAS     |   860        |

*Table of the demand for the top 5 skills for entry/junior level data science jobs and internships*

# What I learned

# Conclusions
