# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explorer * top_paying jobs, *in_demand skills, and where high demand neets high salary in data analytics.
 SQL queries ? Check them out here: [project_sql folder](/project_sql/)

 # Background
 Driven by a quest to navigate the dat analyst job market more effectively, this project was born from a desire to pinpoint top_paid and in_demand skills, streamlining others work to find optimal jobs.

 ### The questions to answer throw those SQL queries were:
 1. What are the top_paying data analyst jobs ?
 2. What skills are required for these top_paying jobs ?
 3. What skills are most demand for data analysis ?
 4. Which skills are associated with higher salaries ?
 5. What are the most optimal skills to learn ?
 
 # Tools I Used
 For my deep dive into the data analyst job market, I harnessed the power of several key tools:

 - **SQL:** the backbone of my analysis, allowing me to query the database and unearth critical insights.
 - **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
 - **Visual Studio Code:** My go-to for database management and executing SQL queries.
 - **PowerBI:** My best tool for results visualization
 - **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

 # The Analysis
 Each query for this project aimed at investigating specific aspects of data analyst job market.
 Here's how i approached each question: 

 ### 1. Top Paying Data Analyst Jobs
 To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the hogh paying opportunities in the field.
 
 ```sql
 SELECT
     job_id,
     job_title,
     job_location,
     job_schedule_type,
     salary_year_avg,
     job_posted_date,
     company_name
 FROM
      job_postings_fact
      LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

 WHERE job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere' AND
      salary_year_avg IS NOT NULL

 ORDER BY
       salary_year_avg DESC

 LIMIT 10
```
### 1.1 : Visualization
![top paying](assets\top_paying_jobs.png)

### 2 . Skills required for top paying jobs

To identify the Skills required for top paying roles, I filtered data analyst positions by average yearly salary. This query highlights the most required skills for those top paying roles in the field.
```sql
WITH top_paying_jobs AS(
    
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL

    ORDER BY
        salary_year_avg DESC

    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
### 2.1 : Visualization
![ required skills](assets\top_paying_job_skills.jpg)

### 3 . Demanded skills for Data Analyst Jobs
This query highlights the most demanded skills for Data Analyst Jobs.
```sql
SELECT
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'

GROUP BY skills
ORDER BY demand_count DESC

LIMIT 10
```
### 3.1: Visualization
![demamded skills](assets\top_demaded_skills.png)

### 4 . Top paying skills
This query highlights the skills associated with the highest salaries.
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS medium_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'AND
      salary_year_avg IS NOT NULL 
      AND job_location = 'Anywhere'
      AND job_work_from_home = true

GROUP BY skills

ORDER BY medium_salary DESC

LIMIT 50
```
### 4.1 : Visualization
![top paying skills](assets\top_paying_skills.jpg)

### 5 . Optimal skills To learn
This query highlights the optimal skills to learn for Data Analyst Jobs.
```sql
WITH demand_skill AS (
    SELECT
       skills_dim.skill_id,
       skills_dim.skills,
       COUNT (skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = True
    GROUP BY 
        skills_dim.skill_id
), paying_skills AS (
    SELECT
      skills_job_dim.skill_id,
      ROUND(AVG(salary_year_avg), 0) AS medium_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
       job_title_short = 'Data Analyst'
       AND salary_year_avg IS NOT NULL 
       AND job_work_from_home = True

    GROUP BY skills_job_dim.skill_id
)


SELECT
    demand_skill.skill_id,
    demand_skill.skills,
    demand_count,
    medium_salary
FROM
    demand_skill 
INNER JOIN paying_skills ON demand_skill.skill_id = paying_skills.skill_id

ORDER BY 
    medium_salary DESC
  
LIMIT 20
```
### 5.1 : Visualization
![Optimal skills to learn](assets\optimal_skills_to_learn.jpg)

 # What I Learned

 Throughout this adventure, I've turbocharged my SQL toolKit with some serious firepower:

 - **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
 - **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
 - **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionnable, insightful SQL queries.  

 # Conclusions  
 
 ### Closing thoughts

 This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizng skill development and job search efforts. Aspiring data analysts can better position themeselves in a competitive job market by focusing on high-demand, high-slary skills, This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.