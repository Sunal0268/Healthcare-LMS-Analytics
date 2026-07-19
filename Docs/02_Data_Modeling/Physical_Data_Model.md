
# Physical Data Model

## Project

Healthcare LMS Analytics Platform

Version: 1.0

Prepared By: Sunal Singh

Date: <Date>

---

# 1. Purpose

The Physical Data Model (PDM) translates the Logical Data Model into an implementation-ready PostgreSQL database design.

Unlike the Conceptual and Logical Data Models, the Physical Data Model defines the exact database objects that will be implemented, including schemas, tables, columns, data types, primary keys, foreign keys, surrogate keys, and relationships.

The design follows a Modern Data Warehouse architecture using the Medallion pattern (Bronze → Silver → Gold) and is optimized for analytics and reporting.

---

# 2. Design Principles

The warehouse follows the same engineering principles used in the Retail Data Warehouse project while adapting them to the Healthcare LMS business domain.

Design Principles:

- PostgreSQL database
- Medallion Architecture
- Star Schema
- Dimensional Modeling
- Surrogate Keys
- Business Keys
- ELT approach
- Analytics-first design
- Power BI consumes only Gold Layer
- dbt models will replace parts of SQL transformations in later phases

---

# 3. Database Architecture

```
Source CSV Files

        │

        ▼

Bronze Schema
(Raw Data)

        │

        ▼

Silver Schema
(Cleaned & Standardized)

        │

        ▼

Gold Schema
(Dimensional Model)

        │

        ▼

Power BI
```

---

# 4. Database Schemas

## Bronze

Purpose

Store raw Healthcare LMS data exactly as received.

Contains

- Raw Students
- Raw Courses
- Raw Instructors
- Raw Institutions
- Raw Campaigns
- Raw Enrollments
- Raw Assessments
- Raw Learning Activity
- Raw Payments

No transformations occur here.

---

## Silver

Purpose

Business-ready cleaned data.

Responsibilities

- Remove duplicates
- Standardize values
- Correct invalid records
- Handle missing values
- Apply business rules
- Validate data

---

## Gold

Purpose

Business-ready analytical layer.

Contains

Dimension Tables

- dim_student
- dim_course
- dim_instructor
- dim_institution
- dim_campaign
- dim_date

Fact Tables

- fact_enrollment
- fact_revenue
- fact_assessment
- fact_engagement

Power BI connects only to this layer.

---

# 5. Dimension Tables

---

## dim_student

Primary Key

student_key (Surrogate Key)

Business Key

student_id

Columns

- student_key
- student_id
- first_name
- last_name
- gender
- date_of_birth
- profession
- specialization
- years_experience
- institution_id
- city
- state
- country
- registration_date
- status

Purpose

Stores descriptive information about learners.

---

## dim_course

Primary Key

course_key

Business Key

course_id

Columns

- course_key
- course_id
- course_name
- category
- subcategory
- difficulty_level
- duration_hours
- language
- instructor_id
- price
- certification_flag
- launch_date
- status

Purpose

Stores course information.

---

## dim_instructor

Primary Key

instructor_key

Business Key

instructor_id

Columns

- instructor_key
- instructor_id
- instructor_name
- qualification
- specialization
- department
- experience_years
- institution_id
- rating

Purpose

Stores instructor details.

---

## dim_institution

Primary Key

institution_key

Business Key

institution_id

Columns

- institution_key
- institution_id
- institution_name
- institution_type
- city
- state
- country
- partnership_status

Purpose

Stores organization information.

---

## dim_campaign

Primary Key

campaign_key

Business Key

campaign_id

Columns

- campaign_key
- campaign_id
- campaign_name
- marketing_channel
- campaign_type
- budget
- campaign_cost
- start_date
- end_date
- status

Purpose

Stores marketing campaign details.

---

## dim_date

Primary Key

date_key

Columns

- date_key
- full_date
- day
- month
- month_name
- quarter
- year
- week
- financial_quarter
- weekend_flag

Purpose

Supports time-based analysis.

---

# 6. Fact Tables

---

## fact_enrollment

Grain

One record per student-course enrollment.

Primary Key

enrollment_key

Foreign Keys

- student_key
- course_key
- campaign_key
- institution_key
- date_key

Measures

- enrollment_count
- completion_flag
- completion_days

Purpose

Central business event.

---

## fact_revenue

Grain

One payment per enrollment.

Primary Key

revenue_key

Foreign Keys

- student_key
- course_key
- campaign_key
- date_key

Measures

- gross_amount
- discount
- tax
- net_amount

Purpose

Financial reporting.

---

## fact_assessment

Grain

One assessment attempt.

Primary Key

assessment_key

Foreign Keys

- student_key
- course_key
- date_key

Measures

- score
- pass_flag
- attempt_number

Purpose

Learning outcome analysis.

---

## fact_engagement

Grain

One learner activity.

Primary Key

activity_key

Foreign Keys

- student_key
- course_key
- date_key

Measures

- activity_duration
- completion_percentage
- engagement_score

Purpose

Learner engagement analysis.

---

# 7. Primary Keys

| Table | Primary Key |
|----------|----------------|
| dim_student | student_key |
| dim_course | course_key |
| dim_instructor | instructor_key |
| dim_institution | institution_key |
| dim_campaign | campaign_key |
| dim_date | date_key |
| fact_enrollment | enrollment_key |
| fact_revenue | revenue_key |
| fact_assessment | assessment_key |
| fact_engagement | activity_key |

---

# 8. Foreign Key Relationships

fact_enrollment

→ dim_student

→ dim_course

→ dim_campaign

→ dim_institution

→ dim_date

---

fact_revenue

→ dim_student

→ dim_course

→ dim_campaign

→ dim_date

---

fact_assessment

→ dim_student

→ dim_course

→ dim_date

---

fact_engagement

→ dim_student

→ dim_course

→ dim_date

---

# 9. Data Types (PostgreSQL)

Typical data types used in implementation:

- BIGINT
- INTEGER
- VARCHAR
- DATE
- TIMESTAMP
- BOOLEAN
- NUMERIC(12,2)

---

# 10. Constraints

The implementation will include:

- Primary Keys
- Foreign Keys
- NOT NULL constraints
- Unique Business Keys
- Check Constraints where applicable

Example:

- Completion Percentage between 0–100
- Revenue cannot be negative
- Enrollment Date cannot be after Completion Date

---

# 11. Indexing Strategy

Indexes will be created on:

- Business Keys
- Foreign Keys
- Frequently filtered columns
- Date columns

This improves dashboard and analytical query performance.

---

# 12. Alignment with Existing Retail Warehouse

This project reuses the engineering principles established in the Retail Data Warehouse.

| Retail Warehouse | Healthcare LMS |
|------------------|----------------|
| Customer | Student |
| Product | Course |
| Sales | Enrollment |
| CRM | LMS |
| ERP | Marketing / Finance |
| dim_customer | dim_student |
| dim_product | dim_course |
| fact_sales | fact_enrollment |

This demonstrates that the same warehouse architecture can support multiple business domains with minimal architectural changes.

---

# 13. Implementation Roadmap

This Physical Data Model will be implemented during Phase 4.

Implementation sequence:

1. Create PostgreSQL schemas
2. Load Bronze tables
3. Transform to Silver
4. Build Gold dimension tables
5. Build Gold fact tables
6. Create relationships
7. Validate data quality
8. Connect Power BI
9. Replace SQL transformations with dbt models

---

# 14. Interview Perspective

The Physical Data Model demonstrates the ability to convert business requirements into a production-ready database design.

It reflects skills expected from Data Analysts, Analytics Engineers, and Data Warehouse Developers, including dimensional modeling, star schema design, surrogate key implementation, and analytical database architecture.

This model forms the technical blueprint for the PostgreSQL warehouse, dbt transformations, SQL pipelines, and Power BI semantic layer used throughout this project.