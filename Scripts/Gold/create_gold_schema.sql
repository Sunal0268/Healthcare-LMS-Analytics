
/*
==============================================================
Healthcare LMS Analytics
Phase 5 – Gold Layer

File Name:
09_create_gold_schema.sql

Purpose:
Create the Gold schema for the Enterprise Data Warehouse.

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- Create Gold Schema
--------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS gold;

--------------------------------------------------------------
-- Comment
--------------------------------------------------------------

COMMENT ON SCHEMA gold IS
'Gold Layer - Business-ready dimensional model (Star Schema) for analytics and reporting.';