
# Business Requirements Document (BRD)

# Healthcare LMS Analytics Platform

Version: 1.0

Project Type:
Independent Portfolio Project

Author:
<Sunal Singh>

---

# 1. Executive Summary

The Healthcare Learning Management System (LMS) supports healthcare professionals through online education, certification programs, instructor-led training, and institutional learning initiatives.

Although operational systems successfully capture business transactions such as learner enrollments, course progress, assessments, marketing campaigns, certifications, and payments, the organization lacks a centralized analytics platform capable of transforming this data into meaningful business insights.

Business users currently spend significant effort manually collecting information from multiple systems before producing reports, resulting in delayed decision-making, inconsistent metrics, and limited visibility into organizational performance.

This project proposes a modern Healthcare LMS Analytics Platform that consolidates business data into a centralized analytical warehouse using Medallion Architecture, enabling reliable reporting, KPI monitoring, and executive dashboards.

---

# 2. Business Problem

The current Healthcare LMS environment has several operational and analytical limitations.

## Existing Challenges

• Business data exists across multiple operational systems.

• Reports are manually prepared using spreadsheets.

• Different departments calculate KPIs differently.

• Executive reporting requires excessive manual effort.

• Marketing effectiveness cannot be accurately measured.

• Instructor performance is difficult to evaluate.

• Learner engagement is not centrally monitored.

• Revenue reporting is delayed.

• Business users cannot perform self-service analytics.

These limitations reduce organizational efficiency and increase reporting complexity.

---

# 3. Business Goals

The organization aims to achieve the following business objectives:

• Create a centralized analytics platform.

• Establish a single source of truth for reporting.

• Improve reporting accuracy.

• Reduce manual reporting effort.

• Improve executive decision-making.

• Monitor learner performance.

• Improve marketing campaign effectiveness.

• Increase learner completion rates.

• Track institutional performance.

• Monitor revenue growth.

---

# 4. Project Objectives

The project aims to:

• Build a modern data warehouse using Medallion Architecture.

• Consolidate Healthcare LMS business data.

• Design an analytical Star Schema.

• Develop reusable SQL transformation pipelines.

• Implement modular transformations using dbt.

• Generate synthetic business datasets using Python.

• Create executive Power BI dashboards.

• Deliver consulting-style project documentation.

---

# 5. Business Scope

## In Scope

Healthcare LMS Analytics

Student Analytics

Course Analytics

Instructor Analytics

Institution Analytics

Campaign Analytics

Revenue Analytics

Assessment Analytics

Executive Reporting

Power BI Dashboards

SQL Analytics

Data Warehouse

dbt Transformations

Data Quality Validation

Business KPI Development

Documentation

---

## Out of Scope

LMS Software Development

User Authentication

Course Creation

Payment Gateway Development

Real-Time Streaming

Machine Learning

Production Deployment

Cloud Infrastructure

---

# 6. Stakeholders

The analytics platform will support multiple business stakeholders.

| Stakeholder | Responsibilities | Information Needed |
|-------------|------------------|--------------------|
| Executive Leadership | Strategic decision making | Revenue, Enrollments, KPIs, Growth |
| Operations Team | Monitor daily LMS operations | Active Learners, Completion, Dropouts |
| Marketing Team | Campaign analysis | Leads, Enrollments, Conversion |
| Finance Team | Revenue monitoring | Payments, Refunds, Monthly Revenue |
| Academic Team | Course quality | Course Ratings, Completion |
| Instructor Managers | Instructor evaluation | Engagement, Ratings, Performance |
| Institutional Partnerships Team | Institutional performance | Institution-wise enrollments |
| Business Analysts | Reporting & analysis | Reliable analytical datasets |
| Data Team | Analytics platform maintenance | Clean business-ready data |

---

# 7. Current ("As-Is") Business Process

Current reporting process follows multiple disconnected operational systems.

LMS

↓

Marketing

↓

Finance

↓

Assessments

↓

Manual Excel Reports

↓

Management

Problems:

• Duplicate reports

• Manual calculations

• Delayed reporting

• Inconsistent KPIs

• No centralized analytics

---

# 8. Future ("To-Be") Business Process

The proposed analytics platform centralizes business reporting.

Operational Systems

↓

Bronze Layer

↓

Silver Layer

↓

Gold Layer

↓

Power BI Dashboards

↓

Business Users

Benefits:

• Single source of truth

• Automated reporting

• Reliable KPIs

• Faster decision making

• Better scalability

---

# 9. Business Questions

The platform should answer the following business questions.

## Executive

How many learners enrolled this month?

How much revenue was generated?

Which institutions contribute most revenue?

What are monthly business trends?

---

## Marketing

Which campaign generated the most enrollments?

Which campaign generated the highest revenue?

What is campaign conversion rate?

Which marketing channels perform best?

---

## Operations

How many learners completed courses?

Which learners are inactive?

Which courses have the highest dropout rate?

What is learner engagement trend?

---

## Academic

Which courses receive the highest ratings?

Which assessments are most difficult?

Which courses need improvement?

---

## Instructor Management

Which instructors perform best?

Which instructors have highest completion rates?

Which instructors receive best learner ratings?

---

## Finance

Monthly Revenue

Revenue by Course

Revenue by Institution

Revenue by Campaign

Refund Trends

---

# 10. Business Success Metrics

The project will measure success using:

• Course Completion Rate

• Enrollment Growth

• Revenue Growth

• Learner Satisfaction

• Instructor Rating

• Campaign ROI

• Assessment Success Rate

• Learner Engagement Score

• Monthly Active Learners

• Institution Contribution

---

# 11. Business Risks

Potential project risks include:

• Missing business data

• Poor data quality

• Duplicate learner records

• Inconsistent business definitions

• Missing relationships

• Incorrect KPI calculations

Mitigation:

• Data validation

• Business rules

• SQL quality checks

• dbt tests

• Documentation

---

# 12. Assumptions

The project assumes:

• Operational systems capture accurate transactional data.

• Business entities can be uniquely identified.

• Historical data is available.

• Business rules remain relatively stable.

• Synthetic datasets realistically represent Healthcare LMS operations.

---

# 13. Constraints

This project is developed as an independent portfolio project.

It does not access any proprietary organizational data.

All datasets are synthetic and created solely for educational and portfolio purposes.

The solution demonstrates analytics engineering concepts rather than production deployment.

---

# 14. Expected Deliverables

Business Documentation

Modern Data Warehouse

Dimensional Data Model

SQL ETL / ELT

Python Data Generation

dbt Models

Power BI Dashboards

Business Recommendations

GitHub Repository

Interview-ready Portfolio Project

---

# 15. Project Approval

This document serves as the initial business understanding for the Healthcare LMS Analytics Platform and defines the business objectives that will guide all subsequent phases of the project.

Every technical component—including data modeling, SQL transformations, dbt models, data quality checks, and Power BI dashboards—must directly support one or more business requirements documented within this BRD.