
# Star Schema Design

## Purpose

The Gold Layer of the Healthcare LMS Analytics Platform is designed using a Star Schema.

A Star Schema simplifies reporting by separating descriptive attributes into Dimension Tables and measurable events into Fact Tables.

This design improves query performance, simplifies Power BI modeling, and supports scalable analytics.

---

# Fact Tables

## Fact_Enrollment

Grain:
One record per student enrollment.

Measures

Enrollment Count

Enrollment Status

Completion Status

Completion Percentage

Enrollment Date

---

## Fact_Revenue

Grain:
One payment transaction per enrollment.

Measures

Revenue

Discount

Net Revenue

Tax

---

## Fact_Assessment

Grain:
One assessment attempt.

Measures

Assessment Score

Pass/Fail

Attempt Number

---

## Fact_Engagement

Grain:
One daily student-course interaction.

Measures

Minutes Watched

Login Count

Videos Completed

Assignments Submitted

---

# Dimension Tables

Dim_Student

Student Name

Gender

Profession

Specialization

Experience

Institution

State

Country

---

Dim_Course

Course Name

Category

Level

Duration

Certification

Price

---

Dim_Instructor

Instructor Name

Department

Qualification

Experience

Rating

---

Dim_Institution

Institution Name

Type

State

Country

---

Dim_Campaign

Campaign Name

Source

Channel

Budget

Launch Date

---

Dim_Date

Date

Month

Quarter

Year

Week

Financial Year

---

# Star Schema Relationship

                     Dim Student
                          |
                          |
Dim Course ---- Fact Enrollment ---- Dim Campaign
                          |
                          |
                    Dim Institution
                          |
                          |
                     Dim Instructor
                          |
                          |
                      Dim Date

Fact Enrollment links with:

Fact Revenue

Fact Assessment

Fact Engagement

---

# Why Star Schema?

• Faster reporting

• Simple joins

• Easy Power BI model

• Better query performance

• Industry standard

• Used by modern data warehouses

---

# Why Not Snowflake?

Snowflake normalization increases join complexity and reduces dashboard performance.

Since reporting is the primary objective, Star Schema is the preferred analytical model.

---

# How This Supports Business Questions

Business Question

→ Best courses?

Fact Enrollment + Dim Course

→ Best instructors?

Fact Assessment + Dim Instructor

→ Campaign ROI?

Fact Revenue + Dim Campaign

→ Monthly revenue?

Fact Revenue + Dim Date

→ Student completion?

Fact Enrollment + Fact Engagement

→ Institution performance?

Fact Enrollment + Dim Institution