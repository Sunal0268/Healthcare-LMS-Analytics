
# Entity Relationship (ER) Diagram

## Purpose

The ER Diagram represents the relationships between business entities within the Healthcare LMS Analytics Platform.

It provides a logical representation of how operational data flows through the system before being transformed into an analytical Star Schema.

Unlike the Star Schema, the ER Diagram focuses on business entities and their relationships rather than reporting optimization.

---

# Business Entities

1. Student
2. Course
3. Instructor
4. Institution
5. Campaign
6. Enrollment
7. Assessment
8. Learning Activity
9. Revenue
10. Date

---

# Entity Relationships

Institution
│
├── has many Students
│
└── offers many Courses

Course
│
├── taught by one Instructor
├── has many Enrollments
├── has many Assessments
└── receives Revenue

Student
│
├── belongs to one Institution
├── enrolls in many Courses
├── completes many Assessments
└── performs many Learning Activities

Campaign
│
└── generates many Enrollments

Enrollment
│
├── belongs to one Student
├── belongs to one Course
├── originates from one Campaign
└── creates Revenue

Assessment
│
└── belongs to one Enrollment

Learning Activity
│
└── belongs to one Enrollment

Revenue
│
└── belongs to one Enrollment

Date
│
└── linked to all transactional tables

---

# Primary Keys

Student_ID
Course_ID
Instructor_ID
Institution_ID
Campaign_ID
Enrollment_ID
Assessment_ID
Activity_ID
Revenue_ID
Date_Key

---

# Foreign Keys

Enrollment.Student_ID → Student

Enrollment.Course_ID → Course

Enrollment.Campaign_ID → Campaign

Course.Instructor_ID → Instructor

Student.Institution_ID → Institution

Assessment.Enrollment_ID → Enrollment

LearningActivity.Enrollment_ID → Enrollment

Revenue.Enrollment_ID → Enrollment

---

# Why this ER Model?

The ER Model represents how the Healthcare LMS operates from a business perspective before optimization for analytics.

It forms the foundation for the dimensional model implemented in the Gold Layer of the data warehouse.