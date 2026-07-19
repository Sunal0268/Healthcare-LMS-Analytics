
# Logical Data Model

## Project

Healthcare LMS Analytics Platform

Version: 1.0

Prepared By: Sunal Singh

Date: <Date>

---

# 1. Purpose

The Logical Data Model (LDM) translates the Conceptual Data Model into a detailed representation of the data required by the Healthcare LMS Analytics Platform.

Unlike the Conceptual Data Model, which identifies only business entities and relationships, the Logical Data Model defines the business attributes associated with each entity while remaining independent of any specific database technology.

This model serves as the foundation for the Physical Data Model, Star Schema, Data Warehouse implementation, dbt models, and Power BI semantic model.

---

# 2. Objectives

The objectives of this document are to:

- Define the business attributes required for each entity.
- Identify business keys for every entity.
- Establish logical relationships between entities.
- Define the business grain of analytical events.
- Ensure all required data supports business reporting and KPIs.
- Prepare for dimensional modeling and PostgreSQL implementation.

---

# 3. Business Grain

The grain defines what one record represents within each entity.

| Entity | Grain |
|---------|-------|
| Student | One record per student |
| Course | One record per course |
| Instructor | One record per instructor |
| Institution | One record per institution |
| Campaign | One record per marketing campaign |
| Enrollment | One record per student-course enrollment |
| Revenue | One record per enrollment payment |
| Assessment | One record per student assessment attempt |
| Learning Activity | One record per learner activity event |
| Date | One record per calendar day |

Establishing the grain ensures consistency across the warehouse and prevents duplicate or ambiguous analytical results.

---

# 4. Logical Entity Definitions

## 4.1 Student

### Business Description

Represents an individual healthcare professional or learner registered in the LMS.

### Business Key

Student ID

### Business Attributes

- Student ID
- First Name
- Last Name
- Full Name
- Email
- Mobile Number
- Gender
- Date of Birth
- Profession
- Specialization
- Years of Experience
- Institution
- City
- State
- Country
- Registration Date
- Status

---

## 4.2 Course

### Business Description

Represents a healthcare learning program available within the LMS.

### Business Key

Course ID

### Business Attributes

- Course ID
- Course Name
- Category
- Subcategory
- Difficulty Level
- Duration
- Language
- Price
- Certification Available
- Instructor
- Launch Date
- Status

---

## 4.3 Instructor

### Business Description

Represents trainers or subject matter experts responsible for delivering courses.

### Business Key

Instructor ID

### Business Attributes

- Instructor ID
- Instructor Name
- Qualification
- Department
- Specialization
- Experience
- Institution
- Rating
- Active Status

---

## 4.4 Institution

### Business Description

Represents healthcare organizations associated with learners or instructors.

### Business Key

Institution ID

### Business Attributes

- Institution ID
- Institution Name
- Institution Type
- City
- State
- Country
- Partnership Status
- Registration Date

---

## 4.5 Campaign

### Business Description

Represents marketing initiatives that drive learner acquisition.

### Business Key

Campaign ID

### Business Attributes

- Campaign ID
- Campaign Name
- Marketing Channel
- Campaign Type
- Start Date
- End Date
- Budget
- Cost
- Target Audience
- Campaign Status

---

## 4.6 Enrollment

### Business Description

Represents a learner registering for a course.

### Business Key

Enrollment ID

### Business Attributes

- Enrollment ID
- Student ID
- Course ID
- Campaign ID
- Enrollment Date
- Enrollment Status
- Payment Status
- Completion Status
- Enrollment Source

Enrollment is the central business transaction of the Healthcare LMS.

---

## 4.7 Revenue

### Business Description

Represents payments received from enrollments.

### Business Key

Revenue ID

### Business Attributes

- Revenue ID
- Enrollment ID
- Student ID
- Course ID
- Gross Amount
- Discount Amount
- Tax Amount
- Net Amount
- Payment Method
- Payment Status
- Payment Date

---

## 4.8 Assessment

### Business Description

Represents learner evaluations conducted within courses.

### Business Key

Assessment ID

### Business Attributes

- Assessment ID
- Student ID
- Course ID
- Assessment Name
- Attempt Number
- Score
- Passing Score
- Result
- Assessment Date

---

## 4.9 Learning Activity

### Business Description

Represents learner engagement events within the LMS.

### Business Key

Activity ID

### Business Attributes

- Activity ID
- Student ID
- Course ID
- Activity Type
- Activity Duration
- Device Type
- Browser
- Activity Timestamp
- Completion Percentage

---

## 4.10 Date

### Business Description

Provides standardized calendar information for analytics.

### Business Key

Date

### Business Attributes

- Date
- Day
- Week
- Month
- Quarter
- Year
- Month Name
- Day Name
- Financial Quarter
- Weekend Indicator

---

# 5. Logical Relationships

| Parent Entity | Child Entity | Relationship |
|--------------|--------------|--------------|
| Institution | Student | One-to-Many |
| Institution | Instructor | One-to-Many |
| Instructor | Course | One-to-Many |
| Student | Enrollment | One-to-Many |
| Course | Enrollment | One-to-Many |
| Campaign | Enrollment | One-to-Many |
| Enrollment | Revenue | One-to-One |
| Student | Assessment | One-to-Many |
| Course | Assessment | One-to-Many |
| Student | Learning Activity | One-to-Many |
| Course | Learning Activity | One-to-Many |
| Date | All Fact Entities | One-to-Many |

---

# 6. Candidate Business Keys

| Entity | Business Key |
|---------|--------------|
| Student | Student ID |
| Course | Course ID |
| Instructor | Instructor ID |
| Institution | Institution ID |
| Campaign | Campaign ID |
| Enrollment | Enrollment ID |
| Revenue | Revenue ID |
| Assessment | Assessment ID |
| Learning Activity | Activity ID |
| Date | Calendar Date |

These business keys uniquely identify records from the source systems. In the Physical Data Model, surrogate keys will be introduced for dimensional modeling.

---

# 7. Alignment with KPIs

The Logical Data Model supports all key business metrics defined in the KPI document.

Examples include:

- Total Students
- Total Enrollments
- Enrollment Growth
- Completion Rate
- Assessment Pass Rate
- Average Assessment Score
- Course Revenue
- Monthly Revenue Trend
- Campaign ROI
- Instructor Rating
- Institution Contribution
- Learner Engagement Score
- Dropout Rate

Each KPI can be calculated using one or more entities defined in this model.

---

# 8. Transition to Physical Data Model

The Logical Data Model defines *what* information needs to be stored.

The Physical Data Model will define *how* that information is implemented in PostgreSQL by introducing:

- Tables
- Columns
- SQL Data Types
- Primary Keys
- Foreign Keys
- Surrogate Keys
- Constraints
- Indexes
- Database Schemas

This transition converts the business-oriented design into an implementation-ready database model.

---

# 9. Interview Perspective

The Logical Data Model demonstrates the ability to transform business requirements into a structured data design before database implementation.

During analytics consulting engagements, this model is reviewed by business analysts, solution architects, and data engineers to ensure that all reporting requirements are captured before development begins.

For this project, the Logical Data Model provides the blueprint for the dimensional model, data warehouse, dbt transformations, and Power BI reporting layer.