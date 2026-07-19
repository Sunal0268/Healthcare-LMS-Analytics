
/*
==============================================================
Learning Activity Analytics
==============================================================
*/

SELECT

activity_type,

COUNT(*) activities

FROM gold.fact_learning_activity

GROUP BY activity_type;



SELECT

device,

COUNT(*) usage_count

FROM gold.fact_learning_activity

GROUP BY device;



SELECT

browser,

COUNT(*) usage_count

FROM gold.fact_learning_activity

GROUP BY browser;



SELECT

ROUND(

AVG(duration_minutes),

2

) avg_learning_minutes

FROM gold.fact_learning_activity;



SELECT

ROUND(

SUM(duration_minutes)/60,

2

) total_learning_hours

FROM gold.fact_learning_activity;