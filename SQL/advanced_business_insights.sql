
/*
==============================================================
Healthcare LMS Analytics
Advanced Business Insights

File Name:
09_advanced_business_insights.sql

Purpose:
Management-level business insights and KPI analysis

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- 1. Revenue Concentration (Pareto)
--------------------------------------------------------------

SELECT

dc.course_name,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.fact_revenue fr

JOIN gold.dim_course dc

ON fr.course_key=dc.course_key

GROUP BY dc.course_name

ORDER BY revenue DESC;



--------------------------------------------------------------
-- 2. Student Lifetime Value
--------------------------------------------------------------

SELECT

ds.student_id,

ds.full_name,

COUNT(DISTINCT fr.enrollment_key) total_courses,

ROUND(SUM(fr.net_revenue),2) lifetime_value

FROM gold.dim_student ds

JOIN gold.fact_revenue fr

ON ds.student_key=fr.student_key

GROUP BY

ds.student_id,
ds.full_name

ORDER BY lifetime_value DESC;



--------------------------------------------------------------
-- 3. High Value Students
--------------------------------------------------------------

SELECT *

FROM

(

SELECT

ds.student_id,

ds.full_name,

ROUND(SUM(fr.net_revenue),2) revenue,

NTILE(4)

OVER

(

ORDER BY SUM(fr.net_revenue) DESC

)

revenue_quartile

FROM gold.dim_student ds

JOIN gold.fact_revenue fr

ON ds.student_key=fr.student_key

GROUP BY

ds.student_id,
ds.full_name

)t

WHERE revenue_quartile=1;



--------------------------------------------------------------
-- 4. Underperforming Courses
--------------------------------------------------------------

SELECT

dc.course_name,

ROUND(AVG(fe.progress_percent),2) avg_progress,

ROUND(AVG(fa.score),2) avg_score

FROM gold.dim_course dc

JOIN gold.fact_enrollment fe

ON dc.course_key=fe.course_key

JOIN gold.fact_assessment fa

ON dc.course_key=fa.course_key

GROUP BY dc.course_name

HAVING AVG(fe.progress_percent)<60

ORDER BY avg_progress;



--------------------------------------------------------------
-- 5. Student Engagement Score
--------------------------------------------------------------

SELECT

ds.full_name,

ROUND(AVG(fe.progress_percent),2) progress,

ROUND(SUM(fla.duration_minutes)/60,2) learning_hours,

ROUND(AVG(fa.score),2) score

FROM gold.dim_student ds

JOIN gold.fact_enrollment fe

ON ds.student_key=fe.student_key

JOIN gold.fact_learning_activity fla

ON ds.student_key=fla.student_key

JOIN gold.fact_assessment fa

ON ds.student_key=fa.student_key

GROUP BY ds.full_name

ORDER BY learning_hours DESC;



--------------------------------------------------------------
-- 6. Monthly Business Snapshot
--------------------------------------------------------------

SELECT

d.year_number,

d.month_number,

COUNT(DISTINCT fr.student_key) students,

COUNT(DISTINCT fr.course_key) courses,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.fact_revenue fr

JOIN gold.dim_date d

ON fr.date_key=d.date_key

GROUP BY

d.year_number,
d.month_number

ORDER BY

d.year_number,
d.month_number;



--------------------------------------------------------------
-- 7. Top Performing Categories
--------------------------------------------------------------

SELECT

dc.category,

COUNT(DISTINCT fr.student_key) learners,

ROUND(SUM(fr.net_revenue),2) revenue,

ROUND(AVG(fa.score),2) avg_score

FROM gold.dim_course dc

JOIN gold.fact_revenue fr

ON dc.course_key=fr.course_key

JOIN gold.fact_assessment fa

ON dc.course_key=fa.course_key

GROUP BY dc.category

ORDER BY revenue DESC;



--------------------------------------------------------------
-- 8. Executive Business Scorecard
--------------------------------------------------------------

SELECT

COUNT(DISTINCT student_key) learners,

COUNT(DISTINCT course_key) courses,

ROUND(SUM(net_revenue),2) revenue,

ROUND(AVG(net_revenue),2) avg_transaction,

ROUND(MAX(net_revenue),2) highest_transaction,

ROUND(AVG(refund_amount),2) avg_refund,

ROUND(AVG(tax_amount),2) avg_tax

FROM gold.fact_revenue;