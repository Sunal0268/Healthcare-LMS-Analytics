
# Business Entities

## Project

Healthcare LMS Analytics Platform

Version: 1.0

Prepared By: Sunal Singh

Date: <Date>

---

# 1. Purpose

This document identifies the core business entities involved in the Healthcare Learning Management System (LMS). These entities represent the key business objects required to support analytics, reporting, and decision-making.

The identified entities will serve as the foundation for:

- Conceptual Data Model
- Logical Data Model
- Physical Data Model
- ER Diagram
- Star Schema
- Data Warehouse Design
- dbt Models
- Power BI Dashboards

This project is an independent portfolio project inspired by real business workflows observed during professional experience in the healthcare education domain. It does not represent an implementation used by any employer.

---

# 2. What is a Business Entity?

A Business Entity is any real-world object, person, event, or concept about which the business wants to collect and analyze data.

Examples include:

- Students
- Courses
- Instructors
- Campaigns
- Enrollments

Each business entity will later become one or more database tables in the Modern Data Warehouse.

---

# 3. Core Business Entities

## 3.1 Student

### Description

Represents healthcare professionals or learners enrolled in one or more healthcare education programs.

### Business Importance

Students are the primary users of the LMS and drive enrollment, engagement, completion, and revenue analytics.

### Examples

- Doctor
- Nurse
- Pharmacist
- Physiotherapist
- Medical Student

### Key Information

- Student ID
- Name
- Email
- Profession
- Specialization
- City
- State
- Country
- Registration Date
- Experience Level

---

## 3.2 Course

### Description

Represents educational programs offered through the LMS.

### Business Importance

Courses generate enrollments, revenue, learner engagement, and completion metrics.

### Examples

- Advanced Cardiology
- Diabetes Management
- ECG Interpretation
- Critical Care Nursing
- Clinical Research

### Key Information

- Course ID
- Course Name
- Category
- Difficulty Level
- Duration
- Price
- Certification
- Active Status

---

## 3.3 Instructor

### Description

Represents subject matter experts responsible for delivering educational content.

### Business Importance

Instructor performance directly influences learner satisfaction, engagement, and course completion.

### Examples

- Senior Cardiologist
- Nursing Educator
- Clinical Faculty
- Medical Professor

### Key Information

- Instructor ID
- Name
- Department
- Qualification
- Experience
- Rating
- Institution

---

## 3.4 Institution

### Description

Represents hospitals, universities, colleges, clinics, or healthcare organizations associated with learners or instructors.

### Business Importance

Institutions contribute significantly to learner acquisition, institutional partnerships, and organizational performance analysis.

### Examples

- Hospital
- Medical College
- Healthcare Organization
- University

### Key Information

- Institution ID
- Institution Name
- Institution Type
- City
- State
- Country

---

## 3.5 Campaign

### Description

Represents marketing initiatives used to promote healthcare courses.

### Business Importance

Campaign analytics help evaluate marketing ROI, enrollment generation, and acquisition effectiveness.

### Examples

- Email Campaign
- LinkedIn Campaign
- Webinar Promotion
- WhatsApp Campaign
- Conference Campaign

### Key Information

- Campaign ID
- Campaign Name
- Marketing Channel
- Campaign Cost
- Start Date
- End Date
- Budget

---

## 3.6 Enrollment

### Description

Represents a learner registering for a healthcare course.

### Business Importance

Enrollment is the central business event that connects students, courses, instructors, institutions, campaigns, and revenue.

### Key Information

- Enrollment ID
- Student
- Course
- Enrollment Date
- Enrollment Status
- Payment Status
- Completion Status

---

## 3.7 Revenue

### Description

Represents financial transactions generated through course enrollments.

### Business Importance

Revenue analytics support financial reporting, profitability analysis, and business growth measurement.

### Key Information

- Revenue ID
- Enrollment
- Payment Amount
- Discount
- Tax
- Net Revenue
- Payment Date

---

## 3.8 Assessment

### Description

Represents quizzes, examinations, certifications, and learner evaluations.

### Business Importance

Assessment performance measures learning effectiveness and certification readiness.

### Key Information

- Assessment ID
- Course
- Student
- Score
- Result
- Attempt Number
- Assessment Date

---

## 3.9 Learning Activity

### Description

Represents learner interactions within the LMS.

### Business Importance

Learning activity helps measure engagement and identify learners at risk of dropping out.

### Examples

- Video Viewed
- Module Completed
- Quiz Attempted
- Discussion Participation
- Resource Download

### Key Information

- Activity ID
- Student
- Course
- Activity Type
- Activity Duration
- Timestamp

---

## 3.10 Date

### Description

Represents calendar information used across all business processes.

### Business Importance

Supports time-series reporting and trend analysis.

### Key Information

- Date
- Day
- Week
- Month
- Quarter
- Year
- Financial Quarter

---

# 4. Business Entity Relationships

The Healthcare LMS ecosystem revolves around the Enrollment process.

High-level relationships:

- A Student can enroll in multiple Courses.
- A Course can have multiple Students.
- A Course is delivered by one or more Instructors.
- Students may belong to an Institution.
- Enrollments may originate from a Marketing Campaign.
- Each Enrollment can generate Revenue.
- Students complete Assessments for Courses.
- Students generate Learning Activities while using the LMS.
- Date supports time-based analysis across all entities.

These relationships will be formally modeled during the Conceptual Data Model and ER Diagram phases.

---

# 5. Business Value of These Entities

The identified entities enable the organization to answer critical business questions such as:

- Which courses generate the highest enrollments?
- Which campaigns deliver the highest ROI?
- Which instructors achieve the best learner satisfaction?
- Which institutions contribute the most learners?
- Which learners are at risk of dropping out?
- How do learner engagement levels impact completion rates?
- What are the monthly revenue trends?
- Which courses require content improvement?

---

# 6. Mapping to Future Data Warehouse

| Business Entity | Planned Warehouse Object |
|-----------------|--------------------------|
| Student | Dim_Student |
| Course | Dim_Course |
| Instructor | Dim_Instructor |
| Institution | Dim_Institution |
| Campaign | Dim_Campaign |
| Date | Dim_Date |
| Enrollment | Fact_Enrollment |
| Revenue | Fact_Revenue |
| Assessment | Fact_Assessment |
| Learning Activity | Fact_Engagement |

---

# 7. Interview Perspective

A Business Entity document demonstrates the ability to identify and structure real-world business objects before designing databases or analytics solutions.

In this project, these entities form the foundation for the Conceptual Data Model, Logical Data Model, Physical Data Model, Star Schema, SQL warehouse, dbt transformations, and Power BI dashboards.

This reflects the approach commonly followed in consulting engagements, where understanding the business domain precedes technical implementation.