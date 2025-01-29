-- SELECT*
-- FROM (
--     SELECT*
--     FROM job_postings_fact
--     WHERE EXTRACT (MONTH FROM job_posted_date) = 1

-- ) AS january_jobs

-- WITH january_jobs AS (
--      SELECT*
--      FROM job_postings_fact
--      WHERE EXTRACT ( MONTH FROM job_posted_date) = 1
-- )

-- SELECT *
-- FROM january_jobs;


-- WITH company_job_count AS (
--        SELECT 
--            company_id,
--            COUNT(*) AS total_jobs
--        FROM job_postings_fact
--        GROUP BY
--            company_id
-- )
-- SELECT 
--      company_dim.company_name AS name,
--      company_job_count.total_jobs
-- FROM company_dim
-- LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
-- ORDER BY total_jobs DESC;

WITH remote_job_skills AS (
SELECT 
     skill_id,
     COUNT(*) AS skill_count

FROM skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE 
     job_postings.job_work_from_home = True AND
     job_postings.job_title_short = 'Data Analyst'
GROUP BY skill_id
)

SELECT
      skills.skill_id,
      skills AS skill_name,
      skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
      skill_id
LIMIT 10;