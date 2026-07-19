
/*
==============================================================
Healthcare LMS Analytics
Phase 5 - Gold Layer

File Name:
10_ddl_gold.sql

Purpose:
Create Dimension Tables for Star Schema

Author:
Sunal Singh
==============================================================
*/

--------------------------------------------------------------
-- DIMENSION : STUDENT
--------------------------------------------------------------

CREATE TABLE gold.dim_student
(
    student_key            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    student_id             INTEGER NOT NULL UNIQUE,
    student_code           VARCHAR(20),
    full_name              VARCHAR(120),
    gender                 VARCHAR(20),
    occupation             VARCHAR(80),
    education_level        VARCHAR(50),
    state                  VARCHAR(50),
    city                   VARCHAR(50),
    registration_date      DATE,

    created_date           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE gold.dim_student IS
'Student Dimension';



--------------------------------------------------------------
-- DIMENSION : COURSE
--------------------------------------------------------------

CREATE TABLE gold.dim_course
(
    course_key             INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    course_id              INTEGER NOT NULL UNIQUE,
    course_code            VARCHAR(20),
    course_name            VARCHAR(150),
    category               VARCHAR(80),
    difficulty_level       VARCHAR(40),
    delivery_mode          VARCHAR(50),
    course_fee             NUMERIC(12,2),
    certificate_available  VARCHAR(10),
    course_status          VARCHAR(20),

    created_date           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE gold.dim_course IS
'Course Dimension';



--------------------------------------------------------------
-- DIMENSION : INSTRUCTOR
--------------------------------------------------------------

CREATE TABLE gold.dim_instructor
(
    instructor_key         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    instructor_id          INTEGER NOT NULL UNIQUE,
    instructor_code        VARCHAR(20),
    instructor_name        VARCHAR(120),
    qualification          VARCHAR(80),
    specialization         VARCHAR(80),
    experience_level       VARCHAR(50),
    employment_type        VARCHAR(50),
    state                  VARCHAR(50),
    city                   VARCHAR(50),
    rating                 NUMERIC(4,2),
    active_status          VARCHAR(20),

    created_date           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE gold.dim_instructor IS
'Instructor Dimension';



--------------------------------------------------------------
-- DIMENSION : INSTITUTION
--------------------------------------------------------------

CREATE TABLE gold.dim_institution
(
    institution_key        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    institution_id         INTEGER NOT NULL UNIQUE,
    institution_code       VARCHAR(20),
    institution_name       VARCHAR(200),
    institution_type       VARCHAR(60),
    ownership              VARCHAR(40),
    state                  VARCHAR(50),
    city                   VARCHAR(50),
    established_year       INTEGER,
    accreditation          VARCHAR(60),

    created_date           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE gold.dim_institution IS
'Institution Dimension';



--------------------------------------------------------------
-- DIMENSION : CAMPAIGN
--------------------------------------------------------------

CREATE TABLE gold.dim_campaign
(
    campaign_key           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    campaign_id            INTEGER NOT NULL UNIQUE,
    campaign_code          VARCHAR(20),
    campaign_name          VARCHAR(150),
    campaign_type          VARCHAR(80),
    marketing_channel      VARCHAR(80),
    campaign_status        VARCHAR(30),

    created_date           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE gold.dim_campaign IS
'Campaign Dimension';



--------------------------------------------------------------
-- DIMENSION : DATE
--------------------------------------------------------------

CREATE TABLE gold.dim_date
(
    date_key               INTEGER PRIMARY KEY,

    calendar_date          DATE UNIQUE,

    day_number             INTEGER,

    month_number           INTEGER,

    month_name             VARCHAR(20),

    quarter_number         INTEGER,

    year_number            INTEGER,

    week_number            INTEGER,

    weekday_name           VARCHAR(20),

    is_weekend             BOOLEAN
);

COMMENT ON TABLE gold.dim_date IS
'Date Dimension';


/*==============================================================
FACT TABLE : ENROLLMENT
==============================================================*/

CREATE TABLE gold.fact_enrollment
(
    enrollment_key        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    enrollment_id         INTEGER UNIQUE,

    student_key           INTEGER NOT NULL,
    course_key            INTEGER NOT NULL,
    instructor_key        INTEGER NOT NULL,
    campaign_key          INTEGER,
    date_key              INTEGER NOT NULL,

    progress_percent      NUMERIC(5,2),
    course_status         VARCHAR(30),
    payment_status        VARCHAR(30)
);

COMMENT ON TABLE gold.fact_enrollment IS
'Enrollment Fact Table';



/*==============================================================
FACT TABLE : REVENUE
==============================================================*/

CREATE TABLE gold.fact_revenue
(
    revenue_key           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    revenue_id            INTEGER UNIQUE,

    enrollment_key        INTEGER NOT NULL,

    student_key           INTEGER NOT NULL,
    course_key            INTEGER NOT NULL,
    instructor_key        INT NOT NULL,

    campaign_key          INT NOT NULL,
    date_key              INTEGER NOT NULL,

    course_fee            NUMERIC(12,2),
    discount_amount       NUMERIC(12,2),
    tax_amount            NUMERIC(12,2),
    total_amount          NUMERIC(12,2),
    refund_amount         NUMERIC(12,2),
    net_revenue           NUMERIC(12,2)
);

COMMENT ON TABLE gold.fact_revenue IS
'Revenue Fact Table';



/*==============================================================
FACT TABLE : ASSESSMENT
==============================================================*/

CREATE TABLE gold.fact_assessment
(
    assessment_key        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    assessment_id         INTEGER UNIQUE,

    enrollment_key        INTEGER,

    student_key           INTEGER NOT NULL,
    course_key            INTEGER NOT NULL,
    date_key              INTEGER NOT NULL,

    maximum_marks         INTEGER,
    score                 NUMERIC(6,2),
    grade                 VARCHAR(5),
    status                VARCHAR(30)
);

COMMENT ON TABLE gold.fact_assessment IS
'Assessment Fact Table';



/*==============================================================
FACT TABLE : LEARNING ACTIVITY
==============================================================*/

CREATE TABLE gold.fact_learning_activity
(
    activity_key          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    activity_id           INTEGER UNIQUE,

    enrollment_key        INTEGER,

    student_key           INTEGER NOT NULL,
    course_key            INTEGER NOT NULL,
    date_key              INTEGER NOT NULL,

    duration_minutes      INTEGER,
    progress_percent      NUMERIC(5,2),
    completed             BOOLEAN,
    activity_type         VARCHAR(50),
    device                VARCHAR(30)
);

COMMENT ON TABLE gold.fact_learning_activity IS
'Learning Activity Fact Table';




/*==============================================================
FOREIGN KEY CONSTRAINTS
==============================================================*/

--------------------------------------------------------------
-- FACT ENROLLMENT
--------------------------------------------------------------

ALTER TABLE gold.fact_enrollment
ADD CONSTRAINT fk_fact_enrollment_student
FOREIGN KEY (student_key)
REFERENCES gold.dim_student(student_key);

ALTER TABLE gold.fact_enrollment
ADD CONSTRAINT fk_fact_enrollment_course
FOREIGN KEY (course_key)
REFERENCES gold.dim_course(course_key);

ALTER TABLE gold.fact_enrollment
ADD CONSTRAINT fk_fact_enrollment_instructor
FOREIGN KEY (instructor_key)
REFERENCES gold.dim_instructor(instructor_key);

ALTER TABLE gold.fact_enrollment
ADD CONSTRAINT fk_fact_enrollment_campaign
FOREIGN KEY (campaign_key)
REFERENCES gold.dim_campaign(campaign_key);

ALTER TABLE gold.fact_enrollment
ADD CONSTRAINT fk_fact_enrollment_date
FOREIGN KEY (date_key)
REFERENCES gold.dim_date(date_key);



/*==============================================================
FACT REVENUE
==============================================================*/

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT fk_fact_revenue_enrollment
FOREIGN KEY (enrollment_key)
REFERENCES gold.fact_enrollment(enrollment_key);

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT fk_fact_revenue_student
FOREIGN KEY (student_key)
REFERENCES gold.dim_student(student_key);

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT fk_fact_revenue_course
FOREIGN KEY (course_key)
REFERENCES gold.dim_course(course_key);

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT fk_fact_revenue_date
FOREIGN KEY (date_key)
REFERENCES gold.dim_date(date_key);

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT fk_revenue_instructor
FOREIGN KEY (instructor_key)
REFERENCES gold.dim_instructor(instructor_key),

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT fk_revenue_campaign
FOREIGN KEY (campaign_key)
REFERENCES gold.dim_campaign(campaign_key)

/*==============================================================
FACT ASSESSMENT
==============================================================*/

ALTER TABLE gold.fact_assessment
ADD CONSTRAINT fk_fact_assessment_student
FOREIGN KEY (student_key)
REFERENCES gold.dim_student(student_key);

ALTER TABLE gold.fact_assessment
ADD CONSTRAINT fk_fact_assessment_course
FOREIGN KEY (course_key)
REFERENCES gold.dim_course(course_key);

ALTER TABLE gold.fact_assessment
ADD CONSTRAINT fk_fact_assessment_date
FOREIGN KEY (date_key)
REFERENCES gold.dim_date(date_key);



/*==============================================================
FACT LEARNING ACTIVITY
==============================================================*/

ALTER TABLE gold.fact_learning_activity
ADD CONSTRAINT fk_fact_activity_student
FOREIGN KEY (student_key)
REFERENCES gold.dim_student(student_key);

ALTER TABLE gold.fact_learning_activity
ADD CONSTRAINT fk_fact_activity_course
FOREIGN KEY (course_key)
REFERENCES gold.dim_course(course_key);

ALTER TABLE gold.fact_learning_activity
ADD CONSTRAINT fk_fact_activity_date
FOREIGN KEY (date_key)
REFERENCES gold.dim_date(date_key);



/*==============================================================
CHECK CONSTRAINTS
==============================================================*/

ALTER TABLE gold.fact_enrollment
ADD CONSTRAINT chk_enrollment_progress
CHECK (progress_percent BETWEEN 0 AND 100);

ALTER TABLE gold.fact_learning_activity
ADD CONSTRAINT chk_learning_progress
CHECK (progress_percent BETWEEN 0 AND 100);

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT chk_net_revenue
CHECK (net_revenue >= 0);

ALTER TABLE gold.fact_revenue
ADD CONSTRAINT chk_total_amount
CHECK (total_amount >= 0);

ALTER TABLE gold.fact_assessment
ADD CONSTRAINT chk_score
CHECK (score >= 0);



/*==============================================================
PERFORMANCE INDEXES
==============================================================*/

--------------------------------------------------------------
-- Student
--------------------------------------------------------------

CREATE INDEX idx_fact_enrollment_student
ON gold.fact_enrollment(student_key);

CREATE INDEX idx_fact_revenue_student
ON gold.fact_revenue(student_key);

CREATE INDEX idx_fact_assessment_student
ON gold.fact_assessment(student_key);

CREATE INDEX idx_fact_activity_student
ON gold.fact_learning_activity(student_key);



--------------------------------------------------------------
-- Course
--------------------------------------------------------------

CREATE INDEX idx_fact_enrollment_course
ON gold.fact_enrollment(course_key);

CREATE INDEX idx_fact_revenue_course
ON gold.fact_revenue(course_key);

CREATE INDEX idx_fact_assessment_course
ON gold.fact_assessment(course_key);

CREATE INDEX idx_fact_activity_course
ON gold.fact_learning_activity(course_key);



--------------------------------------------------------------
-- Date
--------------------------------------------------------------

CREATE INDEX idx_fact_enrollment_date
ON gold.fact_enrollment(date_key);

CREATE INDEX idx_fact_revenue_date
ON gold.fact_revenue(date_key);

CREATE INDEX idx_fact_assessment_date
ON gold.fact_assessment(date_key);

CREATE INDEX idx_fact_activity_date
ON gold.fact_learning_activity(date_key);



--------------------------------------------------------------
-- Campaign
--------------------------------------------------------------

CREATE INDEX idx_fact_enrollment_campaign
ON gold.fact_enrollment(campaign_key);



--------------------------------------------------------------
-- Instructor
--------------------------------------------------------------

CREATE INDEX idx_fact_enrollment_instructor
ON gold.fact_enrollment(instructor_key);

