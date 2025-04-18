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

### 1. Available Entry/Junior Level Data Analyst/Science Roles or Internships
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

Here's the breakdown of the available entry/junior level Data Analyst roles and internships in 2023:
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

Here's the breakdown of the available entry/junior level Data Scientist roles and internships in 2023:
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

Here's the breakdown of the most demanded skills for the available entry/junior level Data Analyst jobs and internships in 2023:
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
Here's the breakdown of the most demanded skills for the available entry/junior level Data Science jobs and internships in 2023:
- Python and SQL are the core technical foundations for entry-level data scientists, widely used for data cleaning, querying, analysis, and machine learning. These languages dominate job postings and form the base of most data workflows.
- Analytical and modeling skills such as machine learning, statistics, and data analysis are highly emphasized, along with tools like scikit-learn, TensorFlow, and R—especially in roles focused on predictive modeling, academic analysis, or AI.
- Collaboration and communication tools like Git, Jupyter, Tableau, and PowerPoint also appear, showing that employers value not only technical fluency but also the ability to present findings and work within reproducible, team-driven environments.
![2_top_10_skills_DS](https://github.com/user-attachments/assets/27cff3d1-3f57-4a2d-8cb6-361842cc35c5)
* Bar graph visualization the count of skills for entry-level and internship data science roles in 2023; ChatGPT generated this graph from my SQL query results*

### 3. In Demand Skills for Entry/Junior Level Roles and Internships
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

Here's the breakdown of the most demanded skills for entry/junior level Data Dnalyst jobs and internships in 2023:
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

*Table of the demand for the top 5 skills for entry/junior level Data Analyst jobs and internships*

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
Here's the breakdown of the most demanded skills for entry/junior level Data Science jobs and internships in 2023:
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

*Table of the demand for the top 5 skills for entry/junior level Data Science jobs and internships*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

Here's a breakdown of the results for top paying skills for entry/junior/intern Data Analysts in 2023:
- Top-paying entry-level roles often blend data analytics with software engineering and machine learning skills. Tools like Docker, Jenkins, Java, Spring, and TensorFlow top the list with average salaries around $103K. This indicates that employers are rewarding junior analysts who bring cross-functional abilities in DevOps, backend development, or AI engineering—areas typically outside the standard analyst toolkit.
- Foundational data analytics tools such as SQL, Python, and R remain essential but offer more moderate pay unless paired with specialized expertise. These skills fall within the $65K–$67K range, showing that while they are in high demand, their widespread availability tempers the salary premium. Analysts looking to boost pay may need to layer these skills with cloud tools, machine learning, or software development experience.
- Soft tools that support collaboration, reporting, and enterprise workflows also appear in higher-paying job listings. Platforms like Jira, Confluence, PowerPoint, and SharePoint are associated with roles averaging $73K–$80K. This suggests that communication, documentation, and cross-team collaboration are seen as valuable traits even in technical roles—especially in larger or client-facing environments.

| Skill        | Average Salary ($) |
|--------------|--------------------|
| Docker       | 103,000.00         |
| Jenkins      | 103,000.00         |
| Java         | 103,000.00         |
| Spring       | 103,000.00         |
| C++          | 103,000.00         |
| TensorFlow   | 103,000.00         |
| C#           | 82,500.00          |
| SAS          | 82,500.00          |
| PHP          | 82,500.00          |
| Jira         | 80,000.00          |
| Confluence   | 80,000.00          |
| JavaScript   | 77,704.50          |
| MATLAB       | 76,928.57          |
| Word         | 75,300.00          |
| Oracle       | 75,204.50          |

*Table of the average salary for the top 15 paying skills for entry/junior/intern level Data Analyst roles*

```sql
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
```
Here's a breakdown of the results for top paying skills for entry/junior/intern Data Scientists in 2023:
- Big data engineering & orchestration skills top the salary charts. Tools like Hadoop ($115K), Airflow ($105K), Kafka, and Spark are strongly associated with higher-paying roles. These suggest that early-career data scientists who bring data pipeline, distributed computing, and workflow orchestration expertise are positioned for higher compensation—blurring the line between data science and data engineering.
- Less common but highly technical languages and tools boost pay significantly. Skills like Perl, Scala, and Neo4j (graph databases) command six-figure salaries, reflecting either niche expertise or demand for rare capabilities in specialized applications like natural language processing, legacy systems, or advanced network analysis.
- Cloud, backend, and infrastructure tools round out high-paying entry-level profiles. Familiarity with AWS, Linux, Java, Spring, Chef, and GitHub/GitLab are tied to roles averaging $85K–$95K. These skills suggest that even junior data scientists are expected to engage with production environments, deployment pipelines, or CI/CD systems, especially in more tech-focused companies.

| Skill         | Average Salary ($) |
|---------------|--------------------|
| Hadoop        | 115,000.00         |
| Perl          | 115,000.00         |
| Airflow       | 105,130.00         |
| Jira          | 105,130.00         |
| Neo4j         | 104,050.00         |
| SPSS          | 102,095.00         |
| Scala         | 100,833.75         |
| Kafka         | 99,912.50          |
| Django        | 97,500.00          |
| GitHub        | 96,594.67          |
| Splunk        | 95,528.13          |
| Spark         | 94,477.55          |
| Elasticsearch | 94,242.88          |
| Go            | 94,050.50          |
| IBM Cloud     | 92,672.50          |

*Table of the average salary for the top 15 paying skills for entry/junior/intern level Data Scientist roles*

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

Here's a breakdown of the most optimal skills for entry/junior/intern level Data Analysts in 2023:
- Tableau, Python, and Excel strike the best balance between demand and salary. Each skill appears in multiple job postings and commands an average salary around or above $69,000, making them key tools for both data analysis and communication.
- SQL remains the most in-demand skill with 12 mentions, offering a strong salary average of $68,006.58. It’s an essential foundation for almost any data analyst role and consistently ranks at the top across demand and compensation charts.
- R and Power BI are valuable supporting skills, offering salaries above $62K, especially useful in roles with statistical or dashboarding components. While their demand is slightly lower, they often appear in roles requiring more analytical depth or business intelligence capabilities.
- Word and PowerPoint may not be technical, but they still appear in high-paying analyst roles. This reflects a consistent expectation for analysts to communicate findings through documentation and presentation—important soft tools alongside technical skills.

| Skill       | Demand Count | Average Salary ($) |
|-------------|---------------|---------------------|
| SQL         | 12            | 68,006.58           |
| Excel       | 9             | 69,722.22           |
| Python      | 7             | 70,154.14           |
| Tableau     | 5             | 70,515.80           |
| R           | 5             | 68,015.80           |
| Word        | 3             | 65,000.00           |
| PowerPoint  | 3             | 65,000.00           |
| Power BI    | 3             | 62,859.67           |

*Table of the most optimal skills for entry/junior/intern level Data Analysts sorted by demand count*

```sql
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
```

Here's a breakdown of the most optimal skills for entry/junior/intern level Data Scientists in 2023:
- Python and SQL top the demand list, appearing in 18 and 16 job postings respectively, with strong average salaries above $80K. These are must-have foundational tools for data wrangling, querying, and building models in production environments.
- R stands out as a top-paying skill, with an average salary of $87,475.38 and 13 mentions—making it especially valuable in statistically intensive or research-heavy roles such as healthcare, academia, or finance.
- Databricks, SAS, and MATLAB are great secondary tools for boosting pay. Though demand is more niche (3–7 postings), these skills often lead to roles in enterprise, cloud-based pipelines, or data warehousing, with average salaries ranging from $75K to $85K.
- Skills like VBA, HTML, JavaScript, and Oracle may not be core to data science, but they offer competitive pay and demonstrate value in hybrid roles that cross into scripting, automation, or legacy system integration.

| Skill      | Demand Count | Average Salary ($) |
|------------|---------------|---------------------|
| Python     | 18            | 81,482.22           |
| SQL        | 16            | 80,178.13           |
| R          | 13            | 87,475.38           |
| SAS        | 7             | 78,571.43           |
| Databricks | 3             | 84,943.33           |
| MATLAB     | 6             | 75,000.00           |
| VBA        | 6             | 75,000.00           |
| HTML       | 6             | 75,000.00           |
| Oracle     | 6             | 75,000.00           |
| JavaScript | 6             | 75,000.00           |

*Table of the most optimal skills for entry/junior/intern level Data Scientists sorted by demand count*

# What I learned

Throughout this journey, I significantly enhanced my SQL skills with powerful new capabilities:

- **Complex Query Crafting:** Built strong SQL skills by learning how to combine tables smoothly and use WITH clauses to create easy-to-follow temporary tables
- **Data Aggregation:** Learned how to use GROUP BY and started using functions like COUNT() and AVG() to quickly summarize and understand data.
- **Analytical Skills:** Improved my ability to solve real-world problems by learning how to turn questions into helpful SQL queries. 

# Conclusions
###Insights
1. **Available Entry/Junior Level Data Analyst/Science Roles or Internships**: Entry-level job availability in both data analytics and data science is strongest for remote positions, with steady hiring across the year and average salaries ranging from $40K–$75K. Common titles like “Junior” or “Intern” roles dominate listings, and a few companies are responsible for a large share of postings.
2. **Skills for Available Jobs**: Required skills for these roles consistently emphasize technical foundations—SQL, Python, and Excel for analysts; Python, SQL, and machine learning frameworks for data scientists. Visualization tools like Tableau and Power BI, as well as collaboration tools like Jupyter and Git, are also frequently requested.
3. **In Demand Skills for Entry/Junior Level Roles and Internships**: High-demand skills include SQL, Excel, and Python for analysts and Python, SQL, and R for data scientists. These tools appeared in thousands of job postings, reinforcing their essential role in early-career success across both fields.
4. **Skills Based on Salary**: Top-paying skills for analysts include cross-functional tools like Docker, Jenkins, and Java ($100K+), while data scientists command the highest salaries with Hadoop, Airflow, and specialized tools like Scala and Spark (ranging from $95K–$115K). Foundational skills like SQL and Python offer solid pay but are more common, reducing their salary premium.
5. **Most Optimal Skills to Learn**: Optimal skills to learn balance high demand and strong salary potential. For analysts, tools like Tableau, Python, and Excel offer the best returns. For data scientists, Python, SQL, and R top the list, while niche tools like Databricks and SAS also unlock high-paying, specialized roles.

###Closing Thoughts

This project significantly strengthened my SQL skills and deepened my understanding of the current job market for entry-level roles in both data analytics and data science. By analyzing real job posting data, I identified which roles are most available, which skills are most in-demand, and which tools lead to higher salaries. For beginners like myself, this information is incredibly valuable, it offers a clear roadmap to focus on foundational tools like SQL, Python, and Excel, while also highlighting the benefit of learning high-paying, specialized tools like Tableau, R, and Databricks. Most importantly, this project reinforced the importance of continuously adapting to industry trends and building a versatile skillset to stay competitive in the evolving data landscape.





