
/*
==============================================================
Healthcare LMS Analytics
Business Analytics

File Name:
03_revenue_analysis.sql

Purpose:
Analyze revenue, payment trends,
refunds, taxes and financial KPIs.

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- 1. Total Revenue
--------------------------------------------------------------

SELECT
ROUND(SUM(net_revenue),2) AS total_revenue
FROM gold.fact_revenue;



--------------------------------------------------------------
-- 2. Monthly Revenue Trend
--------------------------------------------------------------

SELECT

d.year_number,
d.month_number,
d.month_name,

ROUND(SUM(fr.net_revenue),2) AS revenue

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
-- 3. Revenue by Course
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
-- 4. Revenue by Category
--------------------------------------------------------------

SELECT

dc.category,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.fact_revenue fr

JOIN gold.dim_course dc
ON fr.course_key=dc.course_key

GROUP BY dc.category

ORDER BY revenue DESC;



--------------------------------------------------------------
-- 5. Average Revenue per Student
--------------------------------------------------------------

SELECT

ROUND(

SUM(net_revenue)
/COUNT(DISTINCT student_key),

2

) avg_revenue_per_student

FROM gold.fact_revenue;



--------------------------------------------------------------
-- 6. Top Paying Students
--------------------------------------------------------------

SELECT

ds.full_name,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.fact_revenue fr

JOIN gold.dim_student ds

ON fr.student_key=ds.student_key

GROUP BY ds.full_name

ORDER BY revenue DESC

LIMIT 20;



--------------------------------------------------------------
-- 7. Refund Analysis
--------------------------------------------------------------

SELECT

ROUND(SUM(refund_amount),2) refund_amount,

COUNT(*) total_transactions,

ROUND(

AVG(refund_amount),

2

) average_refund

FROM gold.fact_revenue;



--------------------------------------------------------------
-- 8. Tax Collection
--------------------------------------------------------------

SELECT

ROUND(SUM(tax_amount),2) tax_collected

FROM gold.fact_revenue;



--------------------------------------------------------------
-- 9. Daily Revenue
--------------------------------------------------------------

SELECT

d.calendar_date,

ROUND(SUM(fr.net_revenue),2) revenue

FROM gold.fact_revenue fr

JOIN gold.dim_date d

ON fr.date_key=d.date_key

GROUP BY d.calendar_date

ORDER BY d.calendar_date;



--------------------------------------------------------------
--10. Revenue KPI Summary
--------------------------------------------------------------

SELECT

COUNT(*) total_transactions,

COUNT(DISTINCT student_key) unique_students,

COUNT(DISTINCT course_key) unique_courses,

ROUND(SUM(net_revenue),2) total_revenue,

ROUND(AVG(net_revenue),2) avg_transaction,

ROUND(MAX(net_revenue),2) highest_transaction,

ROUND(MIN(net_revenue),2) lowest_transaction

FROM gold.fact_revenue;