
# Conceptual Data Model

## Project

Healthcare LMS Analytics Platform

Version: 1.0

Prepared By: Sunal Singh

Date: <Date>

---

# 1. Purpose

The Conceptual Data Model (CDM) provides a high-level representation of the Healthcare Learning Management System (LMS) from a business perspective.

It identifies the major business entities involved in the LMS ecosystem and illustrates how they interact with one another. The model intentionally avoids technical implementation details such as columns, data types, primary keys, or database constraints.

The objective is to establish a shared understanding between business stakeholders, business analysts, data architects, and analytics engineers before designing the logical and physical database models.

---

# 2. Objectives

The Conceptual Data Model aims to:

- Identify the core business entities within the Healthcare LMS.
- Define the relationships between those entities.
- Align the data model with the business processes documented during the consulting discovery phase.
- Provide a foundation for the Logical Data Model, Physical Data Model, Star Schema, and Data Warehouse architecture.
- Ensure that every future table supports a real business question.

---

# 3. Scope

The Conceptual Data Model covers the primary business processes required for analytics, including:

- Learner Registration
- Course Management
- Marketing Campaigns
- Course Enrollments
- Revenue Generation
- Learning Activities
- Assessments
- Course Completion
- Instructor Performance
- Institutional Participation

Operational system details, authentication mechanisms, and LMS application logic are outside the scope of this model.

---

# 4. Core Business Entities

The Healthcare LMS consists of the following primary business entities:

1. Student
2. Course
3. Instructor
4. Institution
5. Campaign
6. Enrollment
7. Revenue
8. Assessment
9. Learning Activity
10. Date

These entities collectively represent the complete learner journey from marketing acquisition to course completion and business reporting.

---

# 5. High-Level Business Relationships

The relationships between the entities are described below.

### Student

- Registers on the LMS.
- Belongs to an Institution.
- Enrolls in one or more Courses.
- Participates in Learning Activities.
- Attempts Assessments.
- Generates Revenue through paid enrollments.

---

### Course

- Is delivered by one or more Instructors.
- Receives enrollments from Students.
- May be promoted through Marketing Campaigns.
- Contains Assessments.
- Generates Revenue.

---

### Instructor

- Delivers Courses.
- Supports Learners.
- Receives learner ratings.
- Influences learner completion and satisfaction.

---

### Institution

- Has many Students.
- May collaborate with multiple Instructors.
- Contributes to organizational enrollments.

---

### Campaign

- Promotes Courses.
- Generates Student Enrollments.
- Has associated marketing costs.
- Produces measurable Return on Investment (ROI).

---

### Enrollment

Enrollment is the central business event within the Healthcare LMS.

Every enrollment connects:

- Student
- Course
- Campaign
- Institution
- Revenue
- Completion Status

Almost every KPI in this project originates from Enrollment data.

---

### Revenue

Revenue is generated when Students successfully enroll in paid Courses.

Revenue analytics support:

- Financial reporting
- Revenue trends
- Campaign ROI
- Course profitability

---

### Assessment

Students attempt Assessments as part of their learning journey.

Assessment outcomes measure:

- Learning effectiveness
- Certification readiness
- Student performance

---

### Learning Activity

Learning Activity records learner engagement within the LMS.

Examples include:

- Video watched
- Module completed
- Quiz attempted
- Resource downloaded
- Discussion participation

Learning Activity helps identify:

- Highly engaged learners
- At-risk learners
- Dropout patterns

---

### Date

The Date entity provides a common timeline for all business events.

Examples include:

- Enrollment Date
- Payment Date
- Assessment Date
- Completion Date
- Campaign Start Date

It enables trend analysis and time-based reporting.

---

# 6. Conceptual Relationship Diagram

The following diagram represents the business relationships at a conceptual level.

                    Institution
                         |
                         |
                    Student
                         |
                  Enrolls In
                         |
                      Enrollment
                    /      |       \
                   /       |        \
              Course   Campaign   Revenue
                 |
         Delivered By
                 |
            Instructor
                 |
          -----------------
          |               |
     Assessment    Learning Activity

                 |
               Date
     (supports all business events)

---

# 7. Cardinality (Business View)

| Relationship | Cardinality |
|-------------|-------------|
| Institution → Student | One Institution can have many Students |
| Student → Enrollment | One Student can have many Enrollments |
| Course → Enrollment | One Course can have many Enrollments |
| Campaign → Enrollment | One Campaign can generate many Enrollments |
| Enrollment → Revenue | One Enrollment generates one Revenue record |
| Course → Assessment | One Course contains many Assessments |
| Student → Assessment | One Student attempts many Assessments |
| Student → Learning Activity | One Student performs many Learning Activities |
| Instructor → Course | One Instructor can teach multiple Courses |
| Date → Business Events | One Date relates to many business records |

---

# 8. Business Rules

The following business rules define how the Healthcare LMS operates:

1. A Student may enroll in multiple Courses.

2. A Course may have multiple Students.

3. Every Enrollment must belong to one Student.

4. Every Enrollment must belong to one Course.

5. A Course must have at least one Instructor.

6. A Student belongs to one Institution.

7. A Marketing Campaign may generate multiple Enrollments.

8. Revenue can only exist for a valid Enrollment.

9. Learning Activities can only occur after Enrollment.

10. Assessments are linked to both Student and Course.

11. Every business event is associated with a Date.

---

# 9. Business Questions Supported

The Conceptual Data Model enables the analytics platform to answer questions such as:

- Which courses generate the highest enrollments?
- Which campaigns produce the highest ROI?
- Which instructors achieve the highest learner satisfaction?
- Which institutions contribute the most learners?
- Which learners are at risk of dropping out?
- Which courses have the lowest completion rates?
- What are the monthly revenue trends?
- How does learner engagement influence course completion?

---

# 10. Alignment with Future Project Phases

This Conceptual Data Model serves as the blueprint for the remaining phases of the project.

It will directly support:

- Logical Data Model
- Physical Data Model
- ER Diagram
- Star Schema
- PostgreSQL Data Warehouse
- dbt Models
- Power BI Dashboards

Every technical component implemented later will trace back to the business relationships defined in this document.

---

# 11. Interview Perspective

The Conceptual Data Model demonstrates the ability to translate business processes into a structured representation before designing databases or analytics solutions.

During consulting engagements, this model is typically reviewed and validated with business stakeholders before technical implementation begins.

In this project, it ensures that the Healthcare LMS Analytics Platform remains business-driven, scalable, and aligned with stakeholder reporting requirements.