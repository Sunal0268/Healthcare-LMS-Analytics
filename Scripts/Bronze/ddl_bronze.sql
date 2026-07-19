/*
===============================================================================
DDL Script: Create Bronze Tables (PostgreSQL)
===============================================================================

Project:
    Healthcare LMS Analytics

Purpose:
    This script creates all Bronze layer tables.

    The Bronze layer stores raw data exactly as received
    from source CSV files.

    No cleaning, transformation or validation is performed
    in this layer.

Source Files

    • students.csv
    • instructors.csv
    • institutions.csv
    • courses.csv
    • campaigns.csv
    • enrollments.csv
    • revenue.csv
    • assessments.csv
    • learning_activity.csv

===============================================================================
*/

-- ============================================================================
-- Create Schema
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS bronze;

-- ============================================================================
-- STUDENTS
-- ============================================================================

DROP TABLE IF EXISTS bronze.students;

CREATE TABLE bronze.students (

    student_id             INT,

    student_code           VARCHAR(20),

    first_name             VARCHAR(50),

    last_name              VARCHAR(50),

    gender                 VARCHAR(20),

    date_of_birth          DATE,

    email                  VARCHAR(100),

    phone                  VARCHAR(20),

    occupation             VARCHAR(100),

    education_level        VARCHAR(100),

    state                  VARCHAR(100),

    city                   VARCHAR(100),

    registration_date      DATE

);


DROP TABLE IF EXISTS bronze.instructors;

CREATE TABLE bronze.instructors
(
    instructor_id          INT PRIMARY KEY,
    instructor_code        VARCHAR(20),
    first_name             VARCHAR(50),
    last_name              VARCHAR(50),
    gender                 VARCHAR(20),
    email                  VARCHAR(100),
    phone                  VARCHAR(20),
    qualification          VARCHAR(100),
    specialization         VARCHAR(100),
    experience_level       VARCHAR(50),
    employment_type        VARCHAR(50),
    state                  VARCHAR(100),
    city                   VARCHAR(100),
    joining_date           DATE,
    rating                 NUMERIC(3,2),
    active_status          VARCHAR(20)
);


DROP TABLE IF EXISTS bronze.institutions;

CREATE TABLE bronze.institutions
(
    institution_id         INT PRIMARY KEY,
    institution_code       VARCHAR(20),
    institution_name       VARCHAR(200),
    institution_type       VARCHAR(100),
    ownership              VARCHAR(50),
    state                  VARCHAR(100),
    city                   VARCHAR(100),
    established_year       INT,
    accreditation          VARCHAR(100)
);


DROP TABLE IF EXISTS bronze.courses;

CREATE TABLE bronze.courses
(
    course_id                  INT PRIMARY KEY,
    course_code                VARCHAR(20),
    course_name                VARCHAR(200),
    category                   VARCHAR(100),
    difficulty_level           VARCHAR(50),
    duration_weeks             INT,
    delivery_mode              VARCHAR(50),
    course_fee                 NUMERIC(10,2),
    certificate_available      VARCHAR(10),
    course_status              VARCHAR(30)
);

DROP TABLE IF EXISTS bronze.campaigns;

CREATE TABLE bronze.campaigns
(
    campaign_id            INT PRIMARY KEY,
    campaign_code          VARCHAR(20),
    campaign_name          VARCHAR(200),
    campaign_type          VARCHAR(100),
    marketing_channel      VARCHAR(100),
    start_date             DATE,
    end_date               DATE,
    budget                 NUMERIC(12,2),
    leads_generated        INT,
    cost_per_lead          NUMERIC(10,2),
    campaign_status        VARCHAR(30)
);

DROP TABLE IF EXISTS bronze.enrollments;

CREATE TABLE bronze.enrollments
(
    enrollment_id          INT PRIMARY KEY,
    student_id             INT,
    course_id              INT,
    instructor_id          INT,
    campaign_id            INT,
    enrollment_date        DATE,
    completion_date        DATE,
    progress_percent       NUMERIC(5,2),
    course_status          VARCHAR(30),
    payment_status         VARCHAR(30)
);

DROP TABLE IF EXISTS bronze.revenue;

CREATE TABLE bronze.revenue
(
    revenue_id             INT PRIMARY KEY,
    enrollment_id          INT,
    course_id              INT,
    invoice_number         VARCHAR(30),
    invoice_date           DATE,
    course_fee             NUMERIC(10,2),
    discount_percent       NUMERIC(5,2),
    discount_amount        NUMERIC(10,2),
    tax_percent            NUMERIC(5,2),
    tax_amount             NUMERIC(10,2),
    total_amount           NUMERIC(10,2),
    payment_status         VARCHAR(30),
    payment_method         VARCHAR(50),
    refund_amount          NUMERIC(10,2),
    net_revenue            NUMERIC(10,2),
    currency               VARCHAR(10)
);


DROP TABLE IF EXISTS bronze.assessments;

CREATE TABLE bronze.assessments
(
    assessment_id          INT PRIMARY KEY,
    enrollment_id          INT,
    student_id             INT,
    course_id              INT,
    assessment_type        VARCHAR(50),
    assessment_date        DATE,
    maximum_marks          INT,
    score                  NUMERIC(5,2),
    grade                  VARCHAR(10),
    status                 VARCHAR(30)
);

DROP TABLE IF EXISTS bronze.learning_activity;

CREATE TABLE bronze.learning_activity
(
    activity_id            INT PRIMARY KEY,
    enrollment_id          INT,
    student_id             INT,
    course_id              INT,
    activity_date          DATE,
    activity_type          VARCHAR(100),
    duration_minutes       INT,
    progress_percent       NUMERIC(5,2),
    completed              BOOLEAN,
    device                 VARCHAR(50)
);

/*
===============================================================================
DDL : ETL Audit Table
Project : Healthcare LMS Analytics
===============================================================================
*/

CREATE SCHEMA IF NOT EXISTS audit;

CREATE TABLE IF NOT EXISTS audit.etl_log
(
    log_id              SERIAL PRIMARY KEY,

    layer               VARCHAR(20),

    table_name          VARCHAR(100),

    start_time          TIMESTAMP,

    end_time            TIMESTAMP,

    rows_loaded         INTEGER,

    status              VARCHAR(20),

    message             TEXT,

    execution_seconds   NUMERIC(10,2)
);


SELECT 'students' AS table_name, COUNT(*) FROM bronze.students
UNION ALL
SELECT 'instructors', COUNT(*) FROM bronze.instructors
UNION ALL
SELECT 'institutions', COUNT(*) FROM bronze.institutions
UNION ALL
SELECT 'courses', COUNT(*) FROM bronze.courses
UNION ALL
SELECT 'campaigns', COUNT(*) FROM bronze.campaigns
UNION ALL
SELECT 'enrollments', COUNT(*) FROM bronze.enrollments
UNION ALL
SELECT 'revenue', COUNT(*) FROM bronze.revenue
UNION ALL
SELECT 'assessments', COUNT(*) FROM bronze.assessments
UNION ALL
SELECT 'learning_activity', COUNT(*) FROM bronze.learning_activity;
