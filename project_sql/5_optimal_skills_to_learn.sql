
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