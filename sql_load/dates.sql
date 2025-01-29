
-- SELECT
--      job_title_short,
--      company_id,
--      job_location

-- FROM january

-- UNION ALL

-- SELECT
--      job_title_short,
--      company_id,
--      job_location

-- FROM february

-- UNION ALL

-- SELECT
--      job_title_short,
--      company_id,
--      job_location

-- FROM march

SELECT
     job_title_short,
     job_location,
     job_via,
     job_posted_date::date,
     salary_year_avg
FROM(
     SELECT*
     FROM january
     UNION ALL
     SELECT*
     FROM february
     UNION ALL
     SELECT*
     FROM march

) AS quarter_jobs
WHERE quarter_jobs.salary_year_avg > 70000 AND
quarter_jobs.job_title_short = 'Data Analyst'

ORDER BY salary_year_avg DESC;