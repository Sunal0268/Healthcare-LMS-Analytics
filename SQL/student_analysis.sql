
/*
==============================================================
Healthcare LMS Analytics
Business Analytics

File Name:
01_student_analysis.sql

Purpose:
Analyze student demographics, registrations,
engagement and completion trends.

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- 1. Total Students
--------------------------------------------------------------

SELECT
    COUNT(*) AS total_students
FROM gold.dim_student;



--------------------------------------------------------------
-- 2. Students by Gender
--------------------------------------------------------------

SELECT

    gender,

    COUNT(*) AS total_students,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage

FROM gold.dim_student

GROUP BY gender

ORDER BY total_students DESC;



--------------------------------------------------------------
-- 3. Students by Education Level
--------------------------------------------------------------

SELECT

    education_level,

    COUNT(*) AS total_students

FROM gold.dim_student

GROUP BY education_level

ORDER BY total_students DESC;



--------------------------------------------------------------
-- 4. Students by Occupation
--------------------------------------------------------------

SELECT

    occupation,

    COUNT(*) AS total_students

FROM gold.dim_student

GROUP BY occupation

ORDER BY total_students DESC;



--------------------------------------------------------------
-- 5. Top 10 States by Student Count
--------------------------------------------------------------

SELECT

    state,

    COUNT(*) AS total_students

FROM gold.dim_student

GROUP BY state

ORDER BY total_students DESC

LIMIT 10;



--------------------------------------------------------------
-- 6. Top 10 Cities by Student Count
--------------------------------------------------------------

SELECT

    city,

    COUNT(*) AS total_students

FROM gold.dim_student

GROUP BY city

ORDER BY total_students DESC

LIMIT 10;



--------------------------------------------------------------
-- 7. Monthly Student Registrations
--------------------------------------------------------------

SELECT

    d.year_number,

    d.month_number,

    d.month_name,

    COUNT(*) AS registrations

FROM gold.dim_student s

INNER JOIN gold.dim_date d

ON s.registration_date = d.calendar_date

GROUP BY

    d.year_number,

    d.month_number,

    d.month_name

ORDER BY

    d.year_number,

    d.month_number;



--------------------------------------------------------------
-- 8. Registration Trend by Quarter
--------------------------------------------------------------

SELECT

    d.year_number,

    d.quarter_number,

    COUNT(*) AS registrations

FROM gold.dim_student s

INNER JOIN gold.dim_date d

ON s.registration_date = d.calendar_date

GROUP BY

    d.year_number,

    d.quarter_number

ORDER BY

    d.year_number,

    d.quarter_number;



--------------------------------------------------------------
-- 9. Students Enrolled vs Not Enrolled
--------------------------------------------------------------

SELECT

CASE

WHEN fe.student_key IS NULL

THEN 'Not Enrolled'

ELSE 'Enrolled'

END AS enrollment_status,

COUNT(*) AS total_students

FROM gold.dim_student ds

LEFT JOIN gold.fact_enrollment fe

ON ds.student_key = fe.student_key

GROUP BY enrollment_status;



--------------------------------------------------------------
-- 10. Top 20 Students by Number of Enrollments
--------------------------------------------------------------

SELECT

    ds.student_id,

    ds.full_name,

    COUNT(fe.enrollment_id) AS total_enrollments

FROM gold.dim_student ds

INNER JOIN gold.fact_enrollment fe

ON ds.student_key = fe.student_key

GROUP BY

    ds.student_id,

    ds.full_name

ORDER BY total_enrollments DESC

LIMIT 20;



--------------------------------------------------------------
-- 11. Average Course Progress per Student
--------------------------------------------------------------

SELECT

    ds.student_id,

    ds.full_name,

    ROUND(
        AVG(fe.progress_percent),
        2
    ) AS average_progress

FROM gold.dim_student ds

INNER JOIN gold.fact_enrollment fe

ON ds.student_key = fe.student_key

GROUP BY

    ds.student_id,

    ds.full_name

ORDER BY average_progress DESC;



--------------------------------------------------------------
-- 12. Students with Highest Learning Time
--------------------------------------------------------------

SELECT

    ds.student_id,

    ds.full_name,

    SUM(fla.duration_minutes) AS total_learning_minutes,

    ROUND(
        SUM(fla.duration_minutes)/60.0,
        2
    ) AS learning_hours

FROM gold.dim_student ds

INNER JOIN gold.fact_learning_activity fla

ON ds.student_key = fla.student_key

GROUP BY

    ds.student_id,

    ds.full_name

ORDER BY total_learning_minutes DESC

LIMIT 20;



--------------------------------------------------------------
-- 13. Student Completion Distribution
--------------------------------------------------------------

SELECT

    CASE

        WHEN progress_percent = 100
        THEN 'Completed'

        WHEN progress_percent >= 75
        THEN '75-99%'

        WHEN progress_percent >= 50
        THEN '50-74%'

        WHEN progress_percent >= 25
        THEN '25-49%'

        ELSE 'Below 25%'

    END AS progress_band,

    COUNT(*) AS students

FROM gold.fact_enrollment

GROUP BY progress_band

ORDER BY students DESC;



--------------------------------------------------------------
-- 14. Student Performance Summary
--------------------------------------------------------------

SELECT

    ds.student_id,

    ds.full_name,

    COUNT(DISTINCT fe.course_key) AS courses_enrolled,

    ROUND(
        AVG(fa.score),
        2
    ) AS average_score,

    ROUND(
        AVG(fe.progress_percent),
        2
    ) AS average_progress,

    SUM(fla.duration_minutes) AS learning_minutes

FROM gold.dim_student ds

LEFT JOIN gold.fact_enrollment fe

ON ds.student_key = fe.student_key

LEFT JOIN gold.fact_assessment fa

ON ds.student_key = fa.student_key

LEFT JOIN gold.fact_learning_activity fla

ON ds.student_key = fla.student_key

GROUP BY

    ds.student_id,

    ds.full_name

ORDER BY average_score DESC NULLS LAST;