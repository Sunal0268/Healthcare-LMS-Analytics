/*
==============================================================
Healthcare LMS Analytics
Phase 4 – Silver Layer

File Name:
07_proc_load_silver.sql

Purpose:
Loads clean and standardized data from the
Bronze layer into the Silver layer.

Author:
Sunal Singh
==============================================================
*/

CREATE OR REPLACE PROCEDURE silver.load_silver()
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

    ----------------------------------------------------------
    -- ETL Start
    ----------------------------------------------------------

    v_start_time := clock_timestamp();

    RAISE NOTICE '========================================================';
    RAISE NOTICE 'Healthcare LMS Analytics';
    RAISE NOTICE 'Silver Layer ETL Started';
    RAISE NOTICE 'Start Time : %', v_start_time;
    RAISE NOTICE '========================================================';


/*============================================================
MODULE 1 : STUDENTS
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.students';

TRUNCATE TABLE silver.students;

INSERT INTO silver.students
(
    student_id,
    student_code,
    first_name,
    last_name,
    gender,
    date_of_birth,
    email,
    phone,
    occupation,
    education_level,
    state,
    city,
    registration_date
)

SELECT

    student_id,

    TRIM(student_code),

    TRIM(first_name),

    TRIM(last_name),

    CASE
        WHEN LOWER(TRIM(gender))='male' THEN 'Male'
        WHEN LOWER(TRIM(gender))='female' THEN 'Female'
        ELSE 'Other'
    END,

    date_of_birth,

    LOWER(TRIM(email)),

    NULLIF(TRIM(phone),''),

    TRIM(occupation),

    TRIM(education_level),

    TRIM(state),

    TRIM(city),

    registration_date

FROM bronze.students;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Students Loaded Successfully';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM(v_table_end-v_table_start)),2);

/*============================================================
MODULE 2 : INSTRUCTORS
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.instructors';

TRUNCATE TABLE silver.instructors;

INSERT INTO silver.instructors
(
    instructor_id,
    instructor_code,
    first_name,
    last_name,
    gender,
    email,
    phone,
    qualification,
    specialization,
    experience_level,
    employment_type,
    state,
    city,
    joining_date,
    rating,
    active_status
)

SELECT

    instructor_id,

    TRIM(instructor_code),

    TRIM(first_name),

    TRIM(last_name),

    CASE
        WHEN LOWER(TRIM(gender))='male' THEN 'Male'
        WHEN LOWER(TRIM(gender))='female' THEN 'Female'
        ELSE 'Other'
    END,

    LOWER(TRIM(email)),

    NULLIF(TRIM(phone),''),

    TRIM(qualification),

    TRIM(specialization),

    TRIM(experience_level),

    TRIM(employment_type),

    TRIM(state),

    TRIM(city),

    joining_date,

    ROUND(rating,2),

    CASE
        WHEN LOWER(TRIM(active_status))='active' THEN 'Active'
        ELSE 'Inactive'
    END

FROM bronze.instructors;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Instructors Loaded Successfully';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM(v_table_end-v_table_start)),2);



/*============================================================
MODULE 3 : INSTITUTIONS
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.institutions';

TRUNCATE TABLE silver.institutions;

INSERT INTO silver.institutions
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

    TRIM(institution_code),

    TRIM(institution_name),

    TRIM(institution_type),

    TRIM(ownership),

    TRIM(state),

    TRIM(city),

    established_year,

    TRIM(accreditation)

FROM bronze.institutions;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Institutions Loaded Successfully';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM(v_table_end-v_table_start)),2);


/*============================================================
MODULE 4 : COURSES
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.courses';

TRUNCATE TABLE silver.courses;

INSERT INTO silver.courses
(
    course_id,
    course_code,
    course_name,
    category,
    difficulty_level,
    duration_weeks,
    delivery_mode,
    course_fee,
    certificate_available,
    course_status
)

SELECT

    course_id,

    TRIM(course_code),

    TRIM(course_name),

    TRIM(category),

    INITCAP(TRIM(difficulty_level)),

    CASE
        WHEN duration_weeks < 1 THEN 1
        ELSE duration_weeks
    END,

    INITCAP(TRIM(delivery_mode)),

    CASE
        WHEN course_fee < 0 THEN 0
        ELSE ROUND(course_fee,2)
    END,

    CASE
        WHEN LOWER(TRIM(certificate_available))='yes'
            THEN 'Yes'
        ELSE 'No'
    END,

    CASE
        WHEN LOWER(TRIM(course_status))='active'
            THEN 'Active'
        ELSE 'Inactive'
    END

FROM bronze.courses;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Courses Loaded Successfully';
RAISE NOTICE 'Rows : %',v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM(v_table_end-v_table_start)),2);



/*============================================================
MODULE 5 : CAMPAIGNS
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.campaigns';

TRUNCATE TABLE silver.campaigns;

INSERT INTO silver.campaigns
(
    campaign_id,
    campaign_code,
    campaign_name,
    campaign_type,
    marketing_channel,
    start_date,
    end_date,
    budget,
    leads_generated,
    cost_per_lead,
    campaign_status
)

SELECT

    campaign_id,

    TRIM(campaign_code),

    TRIM(campaign_name),

    TRIM(campaign_type),

    TRIM(marketing_channel),

    start_date,

    CASE
        WHEN end_date < start_date
            THEN start_date
        ELSE end_date
    END,

    CASE
        WHEN budget < 0
            THEN 0
        ELSE ROUND(budget,2)
    END,

    CASE
        WHEN leads_generated < 0
            THEN 0
        ELSE leads_generated
    END,

    CASE
        WHEN cost_per_lead < 0
            THEN 0
        ELSE ROUND(cost_per_lead,2)
    END,

    CASE
        WHEN LOWER(TRIM(campaign_status))='active'
            THEN 'Active'
        WHEN LOWER(TRIM(campaign_status))='completed'
            THEN 'Completed'
        WHEN LOWER(TRIM(campaign_status))='planned'
            THEN 'Planned'
        ELSE 'Inactive'
    END

FROM bronze.campaigns;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Campaigns Loaded Successfully';
RAISE NOTICE 'Rows : %',v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM(v_table_end-v_table_start)),2);


/*============================================================
MODULE 6 : ENROLLMENTS
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.enrollments';

TRUNCATE TABLE silver.enrollments;

INSERT INTO silver.enrollments
(
    enrollment_id,
    student_id,
    course_id,
    instructor_id,
    campaign_id,
    enrollment_date,
    completion_date,
    progress_percent,
    course_status,
    payment_status
)

SELECT

    enrollment_id,

    student_id,

    course_id,

    instructor_id,

    campaign_id,

    enrollment_date,

    CASE
        WHEN completion_date < enrollment_date
            THEN enrollment_date
        ELSE completion_date
    END,

    CASE
        WHEN progress_percent < 0
            THEN 0
        WHEN progress_percent > 100
            THEN 100
        ELSE ROUND(progress_percent,2)
    END,

    CASE
        WHEN LOWER(TRIM(course_status))='completed'
            THEN 'Completed'
        WHEN LOWER(TRIM(course_status))='in progress'
            THEN 'In Progress'
        WHEN LOWER(TRIM(course_status))='not started'
            THEN 'Not Started'
        WHEN LOWER(TRIM(course_status))='dropped'
            THEN 'Dropped'
        ELSE 'Unknown'
    END,

    CASE
        WHEN LOWER(TRIM(payment_status))='paid'
            THEN 'Paid'
        WHEN LOWER(TRIM(payment_status))='pending'
            THEN 'Pending'
        WHEN LOWER(TRIM(payment_status))='failed'
            THEN 'Failed'
        WHEN LOWER(TRIM(payment_status))='refunded'
            THEN 'Refunded'
        ELSE 'Unknown'
    END

FROM bronze.enrollments

WHERE
    student_id IS NOT NULL
    AND course_id IS NOT NULL
    AND instructor_id IS NOT NULL
    AND campaign_id IS NOT NULL;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Enrollments Loaded Successfully';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end - v_table_start)), 2);


/*============================================================
MODULE 7 : REVENUE
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.revenue';

TRUNCATE TABLE silver.revenue;

INSERT INTO silver.revenue
(
    revenue_id,
    enrollment_id,
    course_id,
    invoice_number,
    invoice_date,
    course_fee,
    discount_percent,
    discount_amount,
    tax_percent,
    tax_amount,
    total_amount,
    payment_status,
    payment_method,
    refund_amount,
    net_revenue,
    currency
)

SELECT

    revenue_id,

    enrollment_id,

    course_id,

    TRIM(invoice_number),

    invoice_date,

    CASE
        WHEN course_fee < 0 THEN 0
        ELSE ROUND(course_fee,2)
    END,

    CASE
        WHEN discount_percent < 0 THEN 0
        WHEN discount_percent > 100 THEN 100
        ELSE ROUND(discount_percent,2)
    END,

    CASE
        WHEN discount_amount < 0 THEN 0
        ELSE ROUND(discount_amount,2)
    END,

    CASE
        WHEN tax_percent < 0 THEN 0
        WHEN tax_percent > 100 THEN 100
        ELSE ROUND(tax_percent,2)
    END,

    CASE
        WHEN tax_amount < 0 THEN 0
        ELSE ROUND(tax_amount,2)
    END,

    CASE
        WHEN total_amount < 0 THEN 0
        ELSE ROUND(total_amount,2)
    END,

    CASE
        WHEN LOWER(TRIM(payment_status))='paid'
            THEN 'Paid'
        WHEN LOWER(TRIM(payment_status))='pending'
            THEN 'Pending'
        WHEN LOWER(TRIM(payment_status))='failed'
            THEN 'Failed'
        WHEN LOWER(TRIM(payment_status))='refunded'
            THEN 'Refunded'
        ELSE 'Unknown'
    END,

    CASE
        WHEN LOWER(TRIM(payment_method))='upi'
            THEN 'UPI'
        WHEN LOWER(TRIM(payment_method))='credit card'
            THEN 'Credit Card'
        WHEN LOWER(TRIM(payment_method))='debit card'
            THEN 'Debit Card'
        WHEN LOWER(TRIM(payment_method))='net banking'
            THEN 'Net Banking'
        WHEN LOWER(TRIM(payment_method))='wallet'
            THEN 'Wallet'
        ELSE INITCAP(TRIM(payment_method))
    END,

    CASE
        WHEN refund_amount < 0 THEN 0
        ELSE ROUND(refund_amount,2)
    END,

    CASE
        WHEN net_revenue < 0 THEN 0
        ELSE ROUND(net_revenue,2)
    END,

    UPPER(TRIM(currency))

FROM bronze.revenue

WHERE
    enrollment_id IS NOT NULL
    AND course_id IS NOT NULL;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Revenue Loaded Successfully';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end - v_table_start)),2);


/*============================================================
MODULE 8 : ASSESSMENTS
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.assessments';

TRUNCATE TABLE silver.assessments;

INSERT INTO silver.assessments
(
    assessment_id,
    enrollment_id,
    student_id,
    course_id,
    assessment_type,
    assessment_date,
    maximum_marks,
    score,
    grade,
    status
)

SELECT

    assessment_id,

    enrollment_id,

    student_id,

    course_id,

    TRIM(assessment_type),

    assessment_date,

    CASE
        WHEN maximum_marks <= 0 THEN 100
        ELSE maximum_marks
    END,

    CASE
        WHEN score IS NULL THEN NULL
        WHEN score < 0 THEN 0
        WHEN score > maximum_marks THEN maximum_marks
        ELSE ROUND(score,2)
    END,

    CASE
        WHEN grade IS NULL THEN NULL
        ELSE UPPER(TRIM(grade))
    END,

    CASE
        WHEN LOWER(TRIM(status))='completed'
            THEN 'Completed'
        WHEN LOWER(TRIM(status))='pending'
            THEN 'Pending'
        WHEN LOWER(TRIM(status))='missed'
            THEN 'Missed'
        ELSE 'Unknown'
    END

FROM bronze.assessments

WHERE
    enrollment_id IS NOT NULL
    AND student_id IS NOT NULL
    AND course_id IS NOT NULL;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Assessments Loaded Successfully';
RAISE NOTICE 'Rows : %',v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM(v_table_end-v_table_start)),2);



/*============================================================
MODULE 9 : LEARNING ACTIVITY
============================================================*/

v_table_start := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE 'Loading : silver.learning_activity';

TRUNCATE TABLE silver.learning_activity;

INSERT INTO silver.learning_activity
(
    activity_id,
    enrollment_id,
    student_id,
    course_id,
    activity_date,
    activity_type,
    duration_minutes,
    progress_percent,
    completed,
    device
)

SELECT

    activity_id,

    enrollment_id,

    student_id,

    course_id,

    activity_date,

    TRIM(activity_type),

    CASE
        WHEN duration_minutes < 0 THEN 0
        ELSE duration_minutes
    END,

    CASE
        WHEN progress_percent < 0 THEN 0
        WHEN progress_percent > 100 THEN 100
        ELSE ROUND(progress_percent, 2)
    END,

    COALESCE(completed, FALSE),

    INITCAP(TRIM(device))

FROM bronze.learning_activity

WHERE
    enrollment_id IS NOT NULL
    AND student_id IS NOT NULL
    AND course_id IS NOT NULL;

GET DIAGNOSTICS v_rows = ROW_COUNT;

v_table_end := clock_timestamp();

RAISE NOTICE 'Learning Activity Loaded Successfully';
RAISE NOTICE 'Rows : %', v_rows;
RAISE NOTICE 'Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_table_end - v_table_start))::numeric, 2);


/*============================================================
FINAL ETL SUMMARY
============================================================*/

v_end_time := clock_timestamp();

RAISE NOTICE '';
RAISE NOTICE '========================================================';
RAISE NOTICE 'Healthcare LMS Analytics';
RAISE NOTICE 'Silver Layer ETL Completed Successfully';
RAISE NOTICE 'Start Time : %', v_start_time;
RAISE NOTICE 'End Time   : %', v_end_time;
RAISE NOTICE 'Total Time : % sec',
ROUND(EXTRACT(EPOCH FROM (v_end_time - v_start_time)),2);
RAISE NOTICE '========================================================';

EXCEPTION

WHEN OTHERS THEN

    RAISE NOTICE '';
    RAISE NOTICE '========================================================';
    RAISE NOTICE 'Healthcare LMS Analytics';
    RAISE NOTICE 'Silver Layer ETL Failed';
    RAISE NOTICE 'Error : %', SQLERRM;
    RAISE NOTICE '========================================================';

END;
$$;

CALL silver.load_silver();
