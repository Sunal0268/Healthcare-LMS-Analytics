
/*
==============================================================
Healthcare LMS Analytics
Business Analytics

File Name:
02_course_analysis.sql

Purpose:
Analyze course performance, enrollments,
completion, revenue, learner engagement
and course popularity.

Author:
Sunal Singh
==============================================================
*/


--------------------------------------------------------------
-- 1. Total Courses
--------------------------------------------------------------

SELECT
    COUNT(*) AS total_courses
FROM gold.dim_course;



--------------------------------------------------------------
-- 2. Courses by Category
--------------------------------------------------------------

SELECT

    category,

    COUNT(*) AS total_courses

FROM gold.dim_course

GROUP BY category

ORDER BY total_courses DESC;



--------------------------------------------------------------
-- 3. Courses by Difficulty Level
--------------------------------------------------------------

SELECT

    difficulty_level,

    COUNT(*) AS total_courses

FROM gold.dim_course

GROUP BY difficulty_level

ORDER BY total_courses DESC;



--------------------------------------------------------------
-- 4. Course Status Distribution
--------------------------------------------------------------

SELECT

    course_status,

    COUNT(*) AS total_courses

FROM gold.dim_course

GROUP BY course_status

ORDER BY total_courses DESC;



--------------------------------------------------------------
-- 5. Top 20 Most Enrolled Courses
--------------------------------------------------------------

SELECT

    dc.course_id,

    dc.course_name,

    COUNT(fe.enrollment_id) AS total_enrollments

FROM gold.dim_course dc

INNER JOIN gold.fact_enrollment fe

ON dc.course_key = fe.course_key

GROUP BY

    dc.course_id,

    dc.course_name

ORDER BY total_enrollments DESC

LIMIT 20;



--------------------------------------------------------------
-- 6. Course Revenue Ranking
--------------------------------------------------------------

SELECT

    dc.course_name,

    ROUND(
        SUM(fr.net_revenue),
        2
    ) AS total_revenue

FROM gold.dim_course dc

INNER JOIN gold.fact_revenue fr

ON dc.course_key = fr.course_key

GROUP BY dc.course_name

ORDER BY total_revenue DESC;



--------------------------------------------------------------
-- 7. Average Progress by Course
--------------------------------------------------------------

SELECT

    dc.course_name,

    ROUND(
        AVG(fe.progress_percent),
        2
    ) AS average_progress

FROM gold.dim_course dc

INNER JOIN gold.fact_enrollment fe

ON dc.course_key = fe.course_key

GROUP BY dc.course_name

ORDER BY average_progress DESC;



--------------------------------------------------------------
-- 8. Course Completion Rate
--------------------------------------------------------------

SELECT

    dc.course_name,

    COUNT(*) AS total_enrollments,

    SUM(
        CASE
            WHEN fe.progress_percent = 100
            THEN 1
            ELSE 0
        END
    ) AS completed,

    ROUND(

        SUM(
            CASE
                WHEN fe.progress_percent = 100
                THEN 1
                ELSE 0
            END
        ) * 100.0

        / COUNT(*),

        2

    ) AS completion_rate

FROM gold.dim_course dc

INNER JOIN gold.fact_enrollment fe

ON dc.course_key = fe.course_key

GROUP BY dc.course_name

ORDER BY completion_rate DESC;



--------------------------------------------------------------
-- 9. Average Assessment Score by Course
--------------------------------------------------------------

SELECT

    dc.course_name,

    ROUND(
        AVG(fa.score),
        2
    ) AS average_score

FROM gold.dim_course dc

INNER JOIN gold.fact_assessment fa

ON dc.course_key = fa.course_key

GROUP BY dc.course_name

ORDER BY average_score DESC;



--------------------------------------------------------------
-- 10. Learning Hours by Course
--------------------------------------------------------------

SELECT

    dc.course_name,

    ROUND(

        SUM(fla.duration_minutes)/60.0,

        2

    ) AS learning_hours

FROM gold.dim_course dc

INNER JOIN gold.fact_learning_activity fla

ON dc.course_key = fla.course_key

GROUP BY dc.course_name

ORDER BY learning_hours DESC;



--------------------------------------------------------------
-- 11. Revenue per Enrollment
--------------------------------------------------------------

SELECT

    dc.course_name,

    ROUND(
        SUM(fr.net_revenue),
        2
    ) AS total_revenue,

    COUNT(DISTINCT fe.enrollment_id) AS enrollments,

    ROUND(

        SUM(fr.net_revenue)

        /

        COUNT(DISTINCT fe.enrollment_id),

        2

    ) AS revenue_per_enrollment

FROM gold.dim_course dc

INNER JOIN gold.fact_enrollment fe

ON dc.course_key = fe.course_key

INNER JOIN gold.fact_revenue fr

ON fe.enrollment_key = fr.enrollment_key

GROUP BY dc.course_name

ORDER BY revenue_per_enrollment DESC;



--------------------------------------------------------------
-- 12. Monthly Course Enrollments
--------------------------------------------------------------

SELECT

    d.year_number,

    d.month_number,

    dc.course_name,

    COUNT(*) AS enrollments

FROM gold.fact_enrollment fe

INNER JOIN gold.dim_course dc

ON fe.course_key = dc.course_key

INNER JOIN gold.dim_date d

ON fe.date_key = d.date_key

GROUP BY

    d.year_number,

    d.month_number,

    dc.course_name

ORDER BY

    d.year_number,

    d.month_number,

    enrollments DESC;



--------------------------------------------------------------
-- 13. Top Revenue Generating Categories
--------------------------------------------------------------

SELECT

    dc.category,

    ROUND(
        SUM(fr.net_revenue),
        2
    ) AS total_revenue

FROM gold.dim_course dc

INNER JOIN gold.fact_revenue fr

ON dc.course_key = fr.course_key

GROUP BY dc.category

ORDER BY total_revenue DESC;



--------------------------------------------------------------
-- 14. Course Performance Scorecard
--------------------------------------------------------------

SELECT

    dc.course_name,

    COUNT(DISTINCT fe.enrollment_id) AS enrollments,

    ROUND(
        SUM(fr.net_revenue),
        2
    ) AS revenue,

    ROUND(
        AVG(fe.progress_percent),
        2
    ) AS avg_progress,

    ROUND(
        AVG(fa.score),
        2
    ) AS avg_score,

    ROUND(

        SUM(fla.duration_minutes)/60.0,

        2

    ) AS learning_hours

FROM gold.dim_course dc

LEFT JOIN gold.fact_enrollment fe

ON dc.course_key = fe.course_key

LEFT JOIN gold.fact_revenue fr

ON fe.enrollment_key = fr.enrollment_key

LEFT JOIN gold.fact_assessment fa

ON dc.course_key = fa.course_key

LEFT JOIN gold.fact_learning_activity fla

ON dc.course_key = fla.course_key

GROUP BY dc.course_name

ORDER BY revenue DESC NULLS LAST;