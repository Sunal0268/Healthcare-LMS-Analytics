
/*
==============================================================
Healthcare LMS Analytics
Gold Layer Validation

File Name:
12_validate_gold.sql

Purpose:
Validate Gold Layer Data Warehouse

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- GOLD DIMENSIONS
--------------------------------------------------------------

SELECT 'dim_student' AS table_name,
COUNT(*) AS total_rows
FROM gold.dim_student

UNION ALL

SELECT 'dim_course',
COUNT(*)
FROM gold.dim_course

UNION ALL

SELECT 'dim_instructor',
COUNT(*)
FROM gold.dim_instructor

UNION ALL

SELECT 'dim_institution',
COUNT(*)
FROM gold.dim_institution

UNION ALL

SELECT 'dim_campaign',
COUNT(*)
FROM gold.dim_campaign

UNION ALL

SELECT 'dim_date',
COUNT(*)
FROM gold.dim_date;

--------------------------------------------------------------
-- GOLD FACTS
--------------------------------------------------------------

SELECT 'fact_enrollment' AS table_name,
COUNT(*) AS total_rows
FROM gold.fact_enrollment

UNION ALL

SELECT 'fact_revenue',
COUNT(*)
FROM gold.fact_revenue

UNION ALL

SELECT 'fact_assessment',
COUNT(*)
FROM gold.fact_assessment

UNION ALL

SELECT 'fact_learning_activity',
COUNT(*)
FROM gold.fact_learning_activity;


--------------------------------------------------------------
-- DUPLICATE CHECKS
--------------------------------------------------------------

SELECT
student_id,
COUNT(*)

FROM gold.dim_student

GROUP BY student_id

HAVING COUNT(*) > 1;



SELECT
course_id,
COUNT(*)

FROM gold.dim_course

GROUP BY course_id

HAVING COUNT(*) > 1;



SELECT
instructor_id,
COUNT(*)

FROM gold.dim_instructor

GROUP BY instructor_id

HAVING COUNT(*) > 1;


--------------------------------------------------------------
-- NULL FOREIGN KEY CHECK
--------------------------------------------------------------

SELECT *

FROM gold.fact_enrollment

WHERE

student_key IS NULL

OR course_key IS NULL

OR instructor_key IS NULL

OR date_key IS NULL;



SELECT *

FROM gold.fact_revenue

WHERE

student_key IS NULL

OR course_key IS NULL

OR enrollment_key IS NULL

OR date_key IS NULL;



SELECT *

FROM gold.fact_assessment

WHERE

student_key IS NULL

OR course_key IS NULL

OR date_key IS NULL;



SELECT *

FROM gold.fact_learning_activity

WHERE

student_key IS NULL

OR course_key IS NULL

OR date_key IS NULL;




--------------------------------------------------------------
-- ORPHAN CHECKS
--------------------------------------------------------------

SELECT COUNT(*) AS orphan_students

FROM gold.fact_enrollment f

LEFT JOIN gold.dim_student d

ON f.student_key=d.student_key

WHERE d.student_key IS NULL;



SELECT COUNT(*) AS orphan_courses

FROM gold.fact_enrollment f

LEFT JOIN gold.dim_course d

ON f.course_key=d.course_key

WHERE d.course_key IS NULL;



SELECT COUNT(*) AS orphan_dates

FROM gold.fact_enrollment f

LEFT JOIN gold.dim_date d

ON f.date_key=d.date_key

WHERE d.date_key IS NULL;



--------------------------------------------------------------
-- DATE DIMENSION
--------------------------------------------------------------

SELECT

MIN(calendar_date),

MAX(calendar_date),

COUNT(*)

FROM gold.dim_date;



--------------------------------------------------------------
-- REVENUE VALIDATION
--------------------------------------------------------------

SELECT

COUNT(*) AS transactions,

SUM(net_revenue) AS total_revenue,

AVG(net_revenue) AS average_revenue,

MIN(net_revenue) AS minimum,

MAX(net_revenue) AS maximum

FROM gold.fact_revenue;



--------------------------------------------------------------
-- ENROLLMENT SUMMARY
--------------------------------------------------------------

SELECT

course_status,

COUNT(*)

FROM gold.fact_enrollment

GROUP BY course_status

ORDER BY COUNT(*) DESC;



--------------------------------------------------------------
-- ASSESSMENT SUMMARY
--------------------------------------------------------------

SELECT

grade,

COUNT(*)

FROM gold.fact_assessment

GROUP BY grade

ORDER BY grade;


--------------------------------------------------------------
-- LEARNING ACTIVITY
--------------------------------------------------------------

SELECT

activity_type,

COUNT(*)

FROM gold.fact_learning_activity

GROUP BY activity_type

ORDER BY COUNT(*) DESC;



--------------------------------------------------------------
-- WAREHOUSE SUMMARY
--------------------------------------------------------------

SELECT

(SELECT COUNT(*) FROM gold.dim_student) students,

(SELECT COUNT(*) FROM gold.dim_course) courses,

(SELECT COUNT(*) FROM gold.dim_instructor) instructors,

(SELECT COUNT(*) FROM gold.dim_institution) institutions,

(SELECT COUNT(*) FROM gold.dim_campaign) campaigns,

(SELECT COUNT(*) FROM gold.fact_enrollment) enrollments,

(SELECT COUNT(*) FROM gold.fact_revenue) revenue,

(SELECT COUNT(*) FROM gold.fact_assessment) assessments,

(SELECT COUNT(*) FROM gold.fact_learning_activity) learning_activity;

