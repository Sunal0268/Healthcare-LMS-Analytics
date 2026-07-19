
/*
==============================================================
Campaign Performance Analytics
==============================================================
*/

--------------------------------------------------------------
-- Campaign Performance
--------------------------------------------------------------

SELECT

dc.campaign_name,

COUNT(fe.enrollment_id) enrollments,

ROUND(SUM(fr.net_revenue),2) revenue,

ROUND(AVG(fe.progress_percent),2) avg_progress

FROM gold.dim_campaign dc

LEFT JOIN gold.fact_enrollment fe
ON dc.campaign_key=fe.campaign_key

LEFT JOIN gold.fact_revenue fr
ON fe.enrollment_key=fr.enrollment_key

GROUP BY dc.campaign_name

ORDER BY revenue DESC NULLS LAST;



--------------------------------------------------------------
-- Campaign Status Distribution
--------------------------------------------------------------

SELECT

campaign_status,

COUNT(*) campaigns

FROM gold.dim_campaign

GROUP BY campaign_status;



--------------------------------------------------------------
-- Top Campaigns
--------------------------------------------------------------

SELECT

campaign_name,

campaign_type,

marketing_channel

FROM gold.dim_campaign;