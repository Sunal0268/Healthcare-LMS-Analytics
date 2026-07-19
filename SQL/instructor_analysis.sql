
/*
==============================================================
Instructor Analytics
==============================================================
*/

SELECT

di.instructor_name,

COUNT(fe.enrollment_id) total_students,

ROUND(SUM(fr.net_revenue),2) revenue,

ROUND(AVG(fe.progress_percent),2) avg_progress

FROM gold.dim_instructor di

LEFT JOIN gold.fact_enrollment fe

ON di.instructor_key=fe.instructor_key

LEFT JOIN gold.fact_revenue fr

ON fe.enrollment_key=fr.enrollment_key

GROUP BY di.instructor_name

ORDER BY revenue DESC NULLS LAST;



SELECT

specialization,

COUNT(*) instructors

FROM gold.dim_instructor

GROUP BY specialization;



SELECT

experience_level,

COUNT(*) instructors

FROM gold.dim_instructor

GROUP BY experience_level;