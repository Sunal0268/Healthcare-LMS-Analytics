
# Data Dictionary

## Purpose

The Data Dictionary defines the meaning, data type, source, and business purpose of every field used in the Healthcare LMS Analytics Platform.

This document ensures consistency between business users, analysts, and developers.

---

# Dimension Tables

## Dim_Student

| Column | Data Type | Description |
|---------|-----------|-------------|
| Student_Key | Integer | Surrogate key |
| Student_ID | Varchar | Business identifier |
| Student_Name | Varchar | Full name |
| Gender | Varchar | Gender |
| Profession | Varchar | Healthcare profession |
| Specialization | Varchar | Medical specialization |
| Experience_Years | Integer | Years of experience |
| Institution_Key | Integer | Institution reference |

---

## Dim_Course

| Column | Data Type | Description |
|---------|-----------|-------------|
| Course_Key | Integer | Surrogate key |
| Course_ID | Varchar | Business identifier |
| Course_Name | Varchar | Course title |
| Category | Varchar | Course category |
| Level | Varchar | Beginner/Intermediate/Advanced |
| Duration_Hours | Integer | Course duration |
| Price | Decimal | Course price |

---

## Dim_Instructor

| Column | Data Type | Description |
|---------|-----------|-------------|
| Instructor_Key | Integer | Surrogate key |
| Instructor_ID | Varchar | Business identifier |
| Instructor_Name | Varchar | Instructor name |
| Qualification | Varchar | Highest qualification |
| Department | Varchar | Department |
| Rating | Decimal | Average learner rating |

---

## Dim_Institution

| Column | Data Type | Description |
|---------|-----------|-------------|
| Institution_Key | Integer | Surrogate key |
| Institution_ID | Varchar | Business identifier |
| Institution_Name | Varchar | Institution name |
| Institution_Type | Varchar | Hospital/College/University |
| State | Varchar | State |
| Country | Varchar | Country |

---

## Dim_Campaign

| Column | Data Type | Description |
|---------|-----------|-------------|
| Campaign_Key | Integer | Surrogate key |
| Campaign_ID | Varchar | Campaign identifier |
| Campaign_Name | Varchar | Campaign name |
| Source | Varchar | Google, Meta, Email |
| Budget | Decimal | Campaign budget |

---

## Dim_Date

| Column | Data Type | Description |
|---------|-----------|-------------|
| Date_Key | Integer | YYYYMMDD |
| Date | Date | Calendar date |
| Month | Integer | Month |
| Quarter | Integer | Quarter |
| Year | Integer | Year |

---

# Fact Tables

## Fact_Enrollment

| Column | Data Type | Description |
|---------|-----------|-------------|
| Enrollment_ID | Integer | Enrollment identifier |
| Student_Key | Integer | FK to Student |
| Course_Key | Integer | FK to Course |
| Campaign_Key | Integer | FK to Campaign |
| Enrollment_Date | Date | Enrollment date |
| Completion_Status | Varchar | Completed/In Progress |
| Completion_Percentage | Decimal | Progress percentage |

---

## Fact_Revenue

| Column | Data Type | Description |
|---------|-----------|-------------|
| Revenue_ID | Integer | Revenue transaction |
| Enrollment_ID | Integer | Enrollment reference |
| Revenue | Decimal | Amount received |
| Discount | Decimal | Discount |
| Net_Revenue | Decimal | Revenue after discount |

---

## Fact_Assessment

| Column | Data Type | Description |
|---------|-----------|-------------|
| Assessment_ID | Integer | Assessment identifier |
| Enrollment_ID | Integer | Enrollment reference |
| Score | Decimal | Assessment score |
| Pass_Flag | Boolean | Pass or Fail |

---

## Fact_Engagement

| Column | Data Type | Description |
|---------|-----------|-------------|
| Activity_ID | Integer | Activity identifier |
| Enrollment_ID | Integer | Enrollment reference |
| Minutes_Watched | Integer | Learning minutes |
| Login_Count | Integer | Number of logins |
| Assignments_Submitted | Integer | Assignment count |