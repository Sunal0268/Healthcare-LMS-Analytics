
/*
==============================================================
Healthcare LMS Analytics
Phase 5 - Gold Layer

File Name:
11_proc_load_gold.sql

Purpose:
Populate Gold Layer (Dimension & Fact Tables)
from Silver Layer.

Author:
Sunal Singh
==============================================================
*/

CREATE OR REPLACE PROCEDURE gold.load_gold()

LANGUAGE plpgsql

AS
$$

DECLARE

    v_start_time TIMESTAMP;
    v_end_time TIMESTAMP;

    v_table_start TIMESTAMP;
    v_table_end TIMESTAMP;

    v_rows INTEGER;

BEGIN

--------------------------------------------------------------
-- ETL START
--------------------------------------------------------------

v_start_time := clock_timestamp();

--------------------------------------------------------------
-- RESET GOLD LAYER
--------------------------------------------------------------

TRUNCATE TABLE
    gold.fact_learning_activity,
    gold.fact_assessment,
    gold.fact_revenue,
    gold.fact_enrollment,
    gold.dim_campaign,
    gold.dim_institution,
    gold.dim_instructor,
    gold.dim_course,
    gold.dim_student,
    gold.dim_date
RESTART IDENTITY CASCADE;

RAISE NOTICE '';
RAISE NOTICE '=========================================================';
RAISE NOTICE 'Healthcare LMS Analytics';
RAISE NOTICE 'Gold Layer ETL Started';
RAISE NOTICE '=========================================================';



/*==============================================================
MODULE 1 : LOAD DIM_STUDENT
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.dim_student';


INSERT INTO gold.dim_student
(
    student_id,
    student_code,
    full_name,
    gender,
    occupation,
    education_level,
    state,
    city,
    registration_date
)

SELECT

    student_id,

    student_code,

    CONCAT(first_name,' ',last_name),

    gender,

    occupation,

    education_level,

    state,

    city,

    registration_date

FROM silver.students

ORDER BY student_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Student Dimension Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);



/*==============================================================
MODULE 2 : LOAD DIM_COURSE
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.dim_course';


INSERT INTO gold.dim_course
(
    course_id,
    course_code,
    course_name,
    category,
    difficulty_level,
    delivery_mode,
    course_fee,
    certificate_available,
    course_status
)

SELECT

    course_id,

    course_code,

    course_name,

    category,

    difficulty_level,

    delivery_mode,

    course_fee,

    certificate_available,

    course_status

FROM silver.courses

ORDER BY course_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Course Dimension Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);



/*==============================================================
MODULE 3 : LOAD DIM_INSTRUCTOR
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.dim_instructor';


INSERT INTO gold.dim_instructor
(
    instructor_id,
    instructor_code,
    instructor_name,
    qualification,
    specialization,
    experience_level,
    employment_type,
    state,
    city,
    rating,
    active_status
)

SELECT

    instructor_id,

    instructor_code,

    CONCAT(first_name,' ',last_name),

    qualification,

    specialization,

    experience_level,

    employment_type,

    state,

    city,

    rating,

    active_status

FROM silver.instructors

ORDER BY instructor_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Instructor Dimension Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);


/*==============================================================
MODULE 4 : LOAD DIM_INSTITUTION
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.dim_institution';


INSERT INTO gold.dim_institution
(
    institution_id,
    institution_code,
    institution_name,
    institution_type,
    ownership,
    state,
    city,
    established_year,
    accreditation
)

SELECT

    institution_id,
    institution_code,
    institution_name,
    institution_type,
    ownership,
    state,
    city,
    established_year,
    accreditation

FROM silver.institutions

ORDER BY institution_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Institution Dimension Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);



/*==============================================================
MODULE 5 : LOAD DIM_CAMPAIGN
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.dim_campaign';



INSERT INTO gold.dim_campaign
(
    campaign_id,
    campaign_code,
    campaign_name,
    campaign_type,
    marketing_channel,
    campaign_status
)

SELECT

    campaign_id,
    campaign_code,
    campaign_name,
    campaign_type,
    marketing_channel,
    campaign_status

FROM silver.campaigns

ORDER BY campaign_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Campaign Dimension Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);



/*==============================================================
MODULE 6 : LOAD DIM_DATE
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.dim_date';


INSERT INTO gold.dim_date
(
    date_key,
    calendar_date,
    day_number,
    month_number,
    month_name,
    quarter_number,
    year_number,
    week_number,
    weekday_name,
    is_weekend
)

SELECT

    TO_CHAR(d::DATE,'YYYYMMDD')::INTEGER,

    d::DATE,

    EXTRACT(DAY FROM d),

    EXTRACT(MONTH FROM d),

    TO_CHAR(d,'Month'),

    EXTRACT(QUARTER FROM d),

    EXTRACT(YEAR FROM d),

    EXTRACT(WEEK FROM d),

    TO_CHAR(d,'Day'),

    CASE
        WHEN EXTRACT(ISODOW FROM d) IN (6,7)
        THEN TRUE
        ELSE FALSE
    END

FROM
generate_series(

DATE '2023-01-01',

DATE '2030-12-31',

INTERVAL '1 day'

) AS d;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Date Dimension Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);



/*==============================================================
MODULE 7 : LOAD FACT_ENROLLMENT
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.fact_enrollment';


WITH

student_lookup AS
(
    SELECT
        student_id,
        student_key
    FROM gold.dim_student
),

course_lookup AS
(
    SELECT
        course_id,
        course_key
    FROM gold.dim_course
),

instructor_lookup AS
(
    SELECT
        instructor_id,
        instructor_key
    FROM gold.dim_instructor
),

campaign_lookup AS
(
    SELECT
        campaign_id,
        campaign_key
    FROM gold.dim_campaign
),

date_lookup AS
(
    SELECT
        calendar_date,
        date_key
    FROM gold.dim_date
)

INSERT INTO gold.fact_enrollment
(
    enrollment_id,
    student_key,
    course_key,
    instructor_key,
    campaign_key,
    date_key,
    progress_percent,
    course_status,
    payment_status
)

SELECT

    e.enrollment_id,

    sl.student_key,

    cl.course_key,

    il.instructor_key,

    cp.campaign_key,

    dl.date_key,

    e.progress_percent,

    e.course_status,

    e.payment_status

FROM silver.enrollments e

INNER JOIN student_lookup sl
        ON e.student_id = sl.student_id

INNER JOIN course_lookup cl
        ON e.course_id = cl.course_id

INNER JOIN instructor_lookup il
        ON e.instructor_id = il.instructor_id

LEFT JOIN campaign_lookup cp
       ON e.campaign_id = cp.campaign_id

INNER JOIN date_lookup dl
        ON e.enrollment_date = dl.calendar_date

ORDER BY e.enrollment_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Fact Enrollment Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end - v_table_start))::numeric,2);



/*==============================================================
MODULE 8 : LOAD FACT_REVENUE
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.fact_revenue';



WITH enrollment_lookup AS
(
    SELECT
        fe.enrollment_key,
        fe.enrollment_id,
        fe.student_key,
        fe.course_key,
        fe.instructor_key,
        fe.campaign_key
    FROM gold.fact_enrollment fe
),

date_lookup AS
(
    SELECT
        calendar_date,
        date_key
    FROM gold.dim_date
)

INSERT INTO gold.fact_revenue
(
    revenue_id,
    enrollment_key,
    student_key,
    course_key,
    date_key,
    course_fee,
    instructor_key,
    campaign_key,
    discount_amount,
    tax_amount,
    total_amount,
    refund_amount,
    net_revenue
)

SELECT

    r.revenue_id,

    el.enrollment_key,

    el.student_key,

    el.course_key,

    dl.date_key,

    r.course_fee,

    el.instructor_key,

    el.campaign_key,

    r.discount_amount,

    r.tax_amount,

    r.total_amount,

    r.refund_amount,

    r.net_revenue

FROM silver.revenue r

INNER JOIN enrollment_lookup el
        ON r.enrollment_id = el.enrollment_id

INNER JOIN date_lookup dl
        ON r.invoice_date = dl.calendar_date

ORDER BY r.revenue_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Revenue Fact Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);



/*==============================================================
MODULE 9 : LOAD FACT_ASSESSMENT
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.fact_assessment';

WITH

enrollment_lookup AS
(
    SELECT
        enrollment_id,
        student_key,
        course_key
    FROM gold.fact_enrollment
),

date_lookup AS
(
    SELECT
        calendar_date,
        date_key
    FROM gold.dim_date
)

INSERT INTO gold.fact_assessment
(
    assessment_id,
    enrollment_key,
    student_key,
    course_key,
    date_key,
    maximum_marks,
    score,
    grade,
    status
)

SELECT

    a.assessment_id,

    el.enrollment_id,

    el.student_key,

    el.course_key,

    dl.date_key,

    a.maximum_marks,

    a.score,

    a.grade,

    a.status

FROM silver.assessments a

INNER JOIN enrollment_lookup el
        ON a.enrollment_id = el.enrollment_id

INNER JOIN date_lookup dl
        ON a.assessment_date = dl.calendar_date

ORDER BY a.assessment_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Assessment Fact Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);


/*==============================================================
MODULE 10 : LOAD FACT_LEARNING_ACTIVITY
==============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : gold.fact_learning_activity';

WITH

enrollment_lookup AS
(
    SELECT
        enrollment_id,
        student_key,
        course_key
    FROM gold.fact_enrollment
),

date_lookup AS
(
    SELECT
        calendar_date,
        date_key
    FROM gold.dim_date
)

INSERT INTO gold.fact_learning_activity
(
    activity_id,
    enrollment_key,
    student_key,
    course_key,
    date_key,
    duration_minutes,
    progress_percent,
    completed,
    activity_type,
    device
)

SELECT

    la.activity_id,

    el.enrollment_id,

    el.student_key,

    el.course_key,

    dl.date_key,

    la.duration_minutes,

    la.progress_percent,

    la.completed,

    la.activity_type,

    la.device

FROM silver.learning_activity la

INNER JOIN enrollment_lookup el
        ON la.enrollment_id = el.enrollment_id

INNER JOIN date_lookup dl
        ON la.activity_date = dl.calendar_date

ORDER BY la.activity_id;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Learning Activity Fact Loaded';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end-v_table_start))::numeric,2);

v_end_time := clock_timestamp(); 
RAISE NOTICE '';
RAISE NOTICE '========================================================='; 
RAISE NOTICE 'Healthcare LMS Analytics'; 
RAISE NOTICE 'Gold Layer ETL Completed Successfully'; 
RAISE NOTICE '========================================================='; 
RAISE NOTICE 'Start Time : %', v_start_time; 
RAISE NOTICE 'End Time : %', 

v_end_time; RAISE NOTICE 'Duration : % seconds', 

ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time)),2); 

RAISE NOTICE '========================================================='; 
EXCEPTION WHEN OTHERS THEN RAISE NOTICE ''; 
RAISE NOTICE '========================================================='; 
RAISE NOTICE ' GOLD LAYER ETL FAILED'; 
RAISE NOTICE '========================================================='; 
RAISE NOTICE 'Error: %', SQLERRM; 
RAISE NOTICE '========================================================='; 
END; 
$$;


