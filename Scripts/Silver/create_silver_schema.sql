/*
============================================================
Healthcare LMS Analytics
Phase 4 — Silver Layer
File: 05_create_silver_schema.sql

Purpose:
Creates the Silver schema used to store
cleaned, standardized, and validated data
loaded from the Bronze layer.
============================================================
*/

-- Drop existing schema (for development only)
DROP SCHEMA IF EXISTS silver CASCADE;

-- Create Silver schema
CREATE SCHEMA silver;

COMMENT ON SCHEMA silver IS
'Silver layer containing cleaned, validated, and standardized data for downstream analytics.';