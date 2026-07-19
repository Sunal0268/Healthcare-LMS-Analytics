
/*
==============================================================
Assessment Analytics
==============================================================
*/

SELECT

grade,

COUNT(*) students

FROM gold.fact_assessment

GROUP BY grade;



SELECT

status,

COUNT(*) assessments

FROM gold.fact_assessment

GROUP BY status;



SELECT

ROUND(

AVG(score),

2

) average_score

FROM gold.fact_assessment;



SELECT

ROUND(

MAX(score),

2

) highest_score,

ROUND(

MIN(score),

2

) lowest_score

FROM gold.fact_assessment;



SELECT

dc.course_name,

ROUND(

AVG(fa.score),

2

) average_score

FROM gold.fact_assessment fa

JOIN gold.dim_course dc

ON fa.course_key=dc.course_key

GROUP BY dc.course_name

ORDER BY average_score DESC;