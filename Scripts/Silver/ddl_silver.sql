


/*
====================================================================
Healthcare LMS Analytics
Phase 4 – Silver Layer

File Name:
06_ddl_silver.sql

Purpose:
Creates all Silver tables for storing cleaned,
validated and standardized Healthcare LMS data.

Author : Sunal Singh
====================================================================
*/

SET search_path TO silver;


DROP TABLE IF EXISTS silver.students;

CREATE TABLE silver.students
(
    student_id          INT PRIMARY KEY,
    student_code        VARCHAR(20),
    first_name          VARCHAR(50),
    last_name           VARCHAR(50),
    gender              VARCHAR(20),
    date_of_birth       DATE,
    email               VARCHAR(100),
    phone               VARCHAR(20),
    occupation          VARCHAR(100),
    education_level     VARCHAR(100),
    state               VARCHAR(100),
    city                VARCHAR(100),
    registration_date   DATE
);

DROP TABLE IF EXISTS silver.instructors;

CREATE TABLE silver.instructors
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

DROP TABLE IF EXISTS silver.institutions;

CREATE TABLE silver.institutions
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

DROP TABLE IF EXISTS silver.courses;

CREATE TABLE silver.courses
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

DROP TABLE IF EXISTS silver.campaigns;

CREATE TABLE silver.campaigns
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

DROP TABLE IF EXISTS silver.enrollments;

CREATE TABLE silver.enrollments
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

DROP TABLE IF EXISTS silver.revenue;

CREATE TABLE silver.revenue
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

DROP TABLE IF EXISTS silver.assessments;

CREATE TABLE silver.assessments
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

DROP TABLE IF EXISTS silver.learning_activity;

CREATE TABLE silver.learning_activity
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

