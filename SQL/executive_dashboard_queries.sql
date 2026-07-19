
/*
==============================================================
Healthcare LMS Analytics
Executive Dashboard Queries

File Name:
08_executive_dashboard_queries.sql

Purpose:
Executive KPI queries for Power BI Dashboard

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- KPI 1 : Total Students
--------------------------------------------------------------

SELECT
COUNT(*) AS total_students
FROM gold.dim_student;



--------------------------------------------------------------
-- KPI 2 : Total Courses
--------------------------------------------------------------

SELECT
COUNT(*) AS total_courses
FROM gold.dim_course;



--------------------------------------------------------------
-- KPI 3 : Total Instructors
--------------------------------------------------------------

SELECT
COUNT(*) AS total_instructors
FROM gold.dim_instructor;



--------------------------------------------------------------
-- KPI 4 : Total Enrollments
--------------------------------------------------------------

SELECT
COUNT(*) AS total_enrollments
FROM gold.fact_enrollment;



--------------------------------------------------------------
-- KPI 5 : Total Revenue
--------------------------------------------------------------

SELECT
ROUND(SUM(net_revenue),2) AS total_revenue
FROM gold.fact_revenue;



--------------------------------------------------------------
-- KPI 6 : Average Course Progress
--------------------------------------------------------------

SELECT
ROUND(AVG(progress_percent),2) AS avg_progress
FROM gold.fact_enrollment;



--------------------------------------------------------------
-- KPI 7 : Course Completion Rate
--------------------------------------------------------------

SELECT

ROUND(

SUM(
CASE
WHEN progress_percent=100 THEN 1
ELSE 0
END
)*100.0
/
COUNT(*)

,2)

AS completion_rate

FROM gold.fact_enrollment;



--------------------------------------------------------------
-- KPI 8 : Average Assessment Score
--------------------------------------------------------------

SELECT

ROUND(

AVG(score)

,2)

AS avg_score

FROM gold.fact_assessment;



--------------------------------------------------------------
-- KPI 9 : Total Learning Hours
--------------------------------------------------------------

SELECT

ROUND(

SUM(duration_minutes)/60

,2)

AS learning_hours

FROM gold.fact_learning_activity;



--------------------------------------------------------------
-- KPI 10 : Monthly Revenue Trend
--------------------------------------------------------------

SELECT

d.year_number,
d.month_number,
d.month_name,

ROUND(

SUM(fr.net_revenue)

,2)

AS revenue

FROM gold.fact_revenue fr

JOIN gold.dim_date d

ON fr.date_key=d.date_key

GROUP BY

d.year_number,
d.month_number,
d.month_name

ORDER BY

d.year_number,
d.month_number;



--------------------------------------------------------------
-- KPI 11 : Monthly Enrollment Trend
--------------------------------------------------------------

SELECT

d.year_number,
d.month_number,
d.month_name,

COUNT(*) enrollments

FROM gold.fact_enrollment fe

JOIN gold.dim_date d

ON fe.date_key=d.date_key

GROUP BY

d.year_number,
d.month_number,
d.month_name

ORDER BY

d.year_number,
d.month_number;



--------------------------------------------------------------
-- KPI 12 : Revenue by Category
--------------------------------------------------------------

SELECT

dc.category,

ROUND(

SUM(fr.net_revenue)

,2)

revenue

FROM gold.fact_revenue fr

JOIN gold.dim_course dc

ON fr.course_key=dc.course_key

GROUP BY dc.category

ORDER BY revenue DESC;



--------------------------------------------------------------
-- KPI 13 : Top 10 Courses
--------------------------------------------------------------

SELECT

dc.course_name,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.fact_revenue fr

JOIN gold.dim_course dc

ON fr.course_key=dc.course_key

GROUP BY dc.course_name

ORDER BY revenue DESC

LIMIT 10;



--------------------------------------------------------------
-- KPI 14 : Top 10 States
--------------------------------------------------------------

SELECT

ds.state,

COUNT(*) students

FROM gold.dim_student ds

GROUP BY ds.state

ORDER BY students DESC

LIMIT 10;



--------------------------------------------------------------
-- KPI 15 : Top Campaigns
--------------------------------------------------------------

SELECT

dc.campaign_name,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.dim_campaign dc

JOIN gold.fact_enrollment fe

ON dc.campaign_key=fe.campaign_key

JOIN gold.fact_revenue fr

ON fe.enrollment_key=fr.enrollment_key

GROUP BY dc.campaign_name

ORDER BY revenue DESC;



--------------------------------------------------------------
-- KPI 16 : Top Instructors
--------------------------------------------------------------

SELECT

di.instructor_name,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.dim_instructor di

JOIN gold.fact_enrollment fe

ON di.instructor_key=fe.instructor_key

JOIN gold.fact_revenue fr

ON fe.enrollment_key=fr.enrollment_key

GROUP BY di.instructor_name

ORDER BY revenue DESC

LIMIT 10;



--------------------------------------------------------------
-- KPI 17 : Dashboard Summary
--------------------------------------------------------------

SELECT

(SELECT COUNT(*) FROM gold.dim_student) total_students,

(SELECT COUNT(*) FROM gold.dim_course) total_courses,

(SELECT COUNT(*) FROM gold.fact_enrollment) total_enrollments,

(SELECT ROUND(SUM(net_revenue),2) FROM gold.fact_revenue) total_revenue,

(SELECT ROUND(AVG(score),2) FROM gold.fact_assessment) average_score,

(SELECT ROUND(AVG(progress_percent),2) FROM gold.fact_enrollment) average_progress;