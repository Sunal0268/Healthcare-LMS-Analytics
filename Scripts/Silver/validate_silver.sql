/*
==============================================================
Healthcare LMS Analytics
Phase 4 — Silver Layer

File Name:
08_validate_silver.sql

Purpose:
Validate data quality of the Silver Layer before
loading into Gold.

Author:
Sunal Singh
==============================================================
*/

------------------------------------------------------------
-- Row Count Validation
------------------------------------------------------------

SELECT 'Students' AS table_name,
       (SELECT COUNT(*) FROM bronze.students) AS bronze_rows,
       (SELECT COUNT(*) FROM silver.students) AS silver_rows

UNION ALL

SELECT 'Instructors',
       (SELECT COUNT(*) FROM bronze.instructors),
       (SELECT COUNT(*) FROM silver.instructors)

UNION ALL

SELECT 'Institutions',
       (SELECT COUNT(*) FROM bronze.institutions),
       (SELECT COUNT(*) FROM silver.institutions)

UNION ALL

SELECT 'Courses',
       (SELECT COUNT(*) FROM bronze.courses),
       (SELECT COUNT(*) FROM silver.courses)

UNION ALL

SELECT 'Campaigns',
       (SELECT COUNT(*) FROM bronze.campaigns),
       (SELECT COUNT(*) FROM silver.campaigns)

UNION ALL

SELECT 'Enrollments',
       (SELECT COUNT(*) FROM bronze.enrollments),
       (SELECT COUNT(*) FROM silver.enrollments)

UNION ALL

SELECT 'Revenue',
       (SELECT COUNT(*) FROM bronze.revenue),
       (SELECT COUNT(*) FROM silver.revenue)

UNION ALL

SELECT 'Assessments',
       (SELECT COUNT(*) FROM bronze.assessments),
       (SELECT COUNT(*) FROM silver.assessments)

UNION ALL

SELECT 'Learning Activity',
       (SELECT COUNT(*) FROM bronze.learning_activity),
       (SELECT COUNT(*) FROM silver.learning_activity);


------------------------------------------------------------
-- Duplicate Primary Key Validation
------------------------------------------------------------

SELECT
'Students' AS table_name,
COUNT(*)

FROM
(
SELECT student_id
FROM silver.students
GROUP BY student_id
HAVING COUNT(*)>1
)t

UNION ALL

SELECT
'Courses',
COUNT(*)

FROM
(
SELECT course_id
FROM silver.courses
GROUP BY course_id
HAVING COUNT(*)>1
)t

UNION ALL

SELECT
'Enrollments',
COUNT(*)

FROM
(
SELECT enrollment_id
FROM silver.enrollments
GROUP BY enrollment_id
HAVING COUNT(*)>1
)t;


------------------------------------------------------------
-- NULL Primary Keys
------------------------------------------------------------

SELECT

SUM(CASE WHEN student_id IS NULL THEN 1 ELSE 0 END)
AS null_students

FROM silver.students;


SELECT

SUM(CASE WHEN course_id IS NULL THEN 1 ELSE 0 END)
AS null_courses

FROM silver.courses;


SELECT

SUM(CASE WHEN enrollment_id IS NULL THEN 1 ELSE 0 END)
AS null_enrollments

FROM silver.enrollments;


------------------------------------------------------------
-- Progress Validation
------------------------------------------------------------

SELECT *

FROM silver.enrollments

WHERE progress_percent<0
OR progress_percent>100;

SELECT *

FROM silver.learning_activity

WHERE progress_percent<0
OR progress_percent>100;


------------------------------------------------------------
-- Financial Validation
------------------------------------------------------------

SELECT *

FROM silver.revenue

WHERE

course_fee<0
OR discount_percent<0
OR discount_percent>100
OR tax_percent<0
OR tax_percent>100
OR refund_amount<0
OR net_revenue<0;


------------------------------------------------------------
-- Date Validation
------------------------------------------------------------

SELECT *

FROM silver.enrollments

WHERE completion_date<enrollment_date;


SELECT *

FROM silver.campaigns

WHERE end_date<start_date;

SELECT DISTINCT gender

FROM silver.students;


SELECT DISTINCT payment_status

FROM silver.revenue;


SELECT DISTINCT course_status

FROM silver.courses;



------------------------------------------------------------
-- Silver Layer Summary
------------------------------------------------------------

SELECT

(SELECT COUNT(*) FROM silver.students) students,

(SELECT COUNT(*) FROM silver.instructors) instructors,

(SELECT COUNT(*) FROM silver.institutions) institutions,

(SELECT COUNT(*) FROM silver.courses) courses,

(SELECT COUNT(*) FROM silver.campaigns) campaigns,

(SELECT COUNT(*) FROM silver.enrollments) enrollments,

(SELECT COUNT(*) FROM silver.revenue) revenue,

(SELECT COUNT(*) FROM silver.assessments) assessments,

(SELECT COUNT(*) FROM silver.learning_activity) learning_activity;