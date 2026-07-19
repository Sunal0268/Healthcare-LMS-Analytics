
# Healthcare LMS Analytics Platform

## Project Background

This project is an independent portfolio project inspired by real business workflows observed during my professional experience in the Healthcare Education domain.

During my professional experience, I collaborated with stakeholders, supported healthcare professional onboarding, coordinated LMS course creation, participated in campaign execution, assisted in requirement gathering, and contributed to business operations. Although I worked closely with business teams, I did not professionally develop SQL pipelines, dashboards, or data warehouses.

This project has therefore been independently designed to demonstrate how modern analytics engineering practices can transform operational data into meaningful business insights for decision-makers.

The objective is not to replicate my company's systems, but to build a realistic analytics solution inspired by common challenges faced by Healthcare Learning Management Systems.

---

# Business Context

Healthcare organizations increasingly rely on Learning Management Systems (LMS) to deliver professional education, certification programs, compliance training, and continuous medical education to healthcare professionals.

These platforms manage thousands of learners, instructors, institutions, assessments, certifications, marketing campaigns, and financial transactions.

Every learner interaction generates valuable business data including:

• Course Enrollments

• Learning Progress

• Assessment Scores

• Course Completion

• Certificates

• Revenue

• Marketing Campaign Performance

• Instructor Performance

• Institution Participation

While operational systems successfully capture these transactions, business users often struggle to convert this data into meaningful insights due to fragmented reporting and disconnected systems.

As a result, business decisions become slower, reporting becomes manual, and opportunities for improvement remain hidden.

---

# Current Business Challenges

The Healthcare LMS currently faces several common analytics challenges.

## 1. Fragmented Data Sources

Business information is spread across multiple operational systems including:

- Learning Management System
- Marketing Platform
- Finance Records
- Institution Records
- Assessment Data

Since these systems operate independently, business users cannot obtain a unified view of organizational performance.

---

## 2. Manual Reporting

Most reports require manual data collection from different teams.

This leads to:

- Time-consuming reporting
- Inconsistent calculations
- Delayed decision making
- Increased human errors

---

## 3. Limited Executive Visibility

Senior management lacks a centralized dashboard to monitor critical business metrics such as:

- Total Enrollments
- Monthly Revenue
- Course Completion Rate
- Learner Engagement
- Instructor Performance
- Campaign Effectiveness

Decision-makers therefore rely on static spreadsheets instead of interactive analytics.

---

## 4. Inefficient Marketing Analysis

Marketing teams invest in multiple campaigns but cannot accurately determine:

- Which campaign generated the highest enrollments
- Which campaign generated the highest revenue
- Campaign conversion rates
- Cost per enrollment
- Return on marketing investment

---

## 5. Limited Learner Insights

Operations teams cannot easily identify:

- Learners likely to discontinue courses
- Low engagement learners
- Completion trends
- Learning behavior
- Assessment performance

Without proactive analytics, learner retention becomes difficult.

---

## 6. Instructor Performance Monitoring

Training managers require objective measures to evaluate instructor performance.

However, instructor-related information exists across different datasets and cannot easily answer questions such as:

- Which instructors achieve the highest completion rates?
- Which instructors receive the highest learner ratings?
- Which instructors generate the highest learner engagement?

---

## 7. Revenue Monitoring

Finance teams require regular monitoring of:

- Monthly Revenue
- Revenue by Institution
- Revenue by Course
- Revenue by Campaign
- Refund Trends

Without centralized reporting, financial analysis becomes time-consuming.

---

# Problem Statement

Although operational systems successfully capture day-to-day business transactions, the Healthcare LMS lacks a centralized analytics platform capable of integrating data from multiple business functions into a single trusted source for reporting and decision making.

As a result:

- Business users spend excessive time preparing reports.
- Decision-makers lack real-time visibility.
- Data inconsistencies reduce confidence in reports.
- Business opportunities remain undiscovered.
- Reporting processes are not scalable.

---

# Project Vision

The vision of this project is to design and implement a modern Healthcare LMS Analytics Platform that consolidates operational data into a centralized analytical environment.

The platform will enable business stakeholders to monitor key performance indicators, evaluate organizational performance, identify business opportunities, and support strategic decision-making through interactive dashboards and analytics.

Rather than producing isolated reports, the platform aims to establish a scalable analytics foundation that can evolve with future business needs.

---

# Project Objectives

The primary objectives of this project are:

• Build a Modern Data Warehouse using Medallion Architecture.

• Integrate multiple Healthcare LMS business domains into a unified analytical model.

• Design an optimized Star Schema for business intelligence.

• Apply modern analytics engineering principles using SQL and dbt.

• Generate realistic healthcare education datasets using Python.

• Perform data quality validation throughout the transformation process.

• Develop executive-level Power BI dashboards.

• Produce business documentation similar to consulting engagements.

• Demonstrate end-to-end analytics capabilities from business understanding to business recommendations.

---

# Proposed Solution

The proposed solution consists of a complete analytics platform built using modern analytics engineering practices.

The architecture will include:

Operational Source Systems

↓

Bronze Layer

(Raw Data)

↓

Silver Layer

(Data Cleaning, Validation, Standardization)

↓

Gold Layer

(Business-ready Star Schema)

↓

Power BI Dashboards

↓

Business Insights & Decision Making

The Gold Layer will become the organization's trusted analytical source and the only layer consumed by Power BI.

---

# Expected Business Outcomes

Successful implementation of the proposed solution will enable the organization to:

• Reduce manual reporting effort.

• Improve reporting accuracy.

• Monitor business KPIs through centralized dashboards.

• Identify high-performing courses and instructors.

• Evaluate marketing campaign effectiveness.

• Monitor learner engagement and completion.

• Improve operational efficiency.

• Enable faster executive decision-making.

• Build a scalable analytics platform for future expansion.

---

# Project Scope

The project focuses on analytics rather than operational system development.

Included within scope:

✓ Healthcare LMS Analytics

✓ Data Warehouse Design

✓ Data Modeling

✓ SQL Transformations

✓ dbt Models

✓ Python-based Data Generation

✓ Data Quality Validation

✓ Business KPI Development

✓ Power BI Dashboards

✓ Consulting Documentation

Outside the project scope:

✗ LMS Application Development

✗ User Authentication

✗ Real-time Streaming

✗ Machine Learning Models

✗ Production Deployment

---

# Success Criteria

The project will be considered successful if it demonstrates:

• A reusable modern data warehouse architecture.

• Business-driven dimensional data modeling.

• Reliable analytical datasets.

• Well-documented transformation logic.

• Accurate KPI calculations.

• Executive-ready dashboards.

• Strong analytics engineering practices.

• Comprehensive business documentation.

• Clear business recommendations.

• End-to-end analytics lifecycle implementation.

---

# Technology Stack

Database:
PostgreSQL

Programming:
SQL
Python

Analytics Engineering:
dbt

Business Intelligence:
Power BI

Version Control:
GitHub

Documentation:
Markdown

Architecture:
Medallion Architecture
Star Schema

---

# Project Deliverables

The final solution will include:

- Business Requirements Document (BRD)
- Functional Requirements Document (FRD)
- KPI Definitions
- Data Dictionary
- Conceptual Data Model
- Logical Data Model
- Physical Data Model
- ER Diagram
- Star Schema
- Data Warehouse Architecture
- SQL ETL / ELT Scripts
- dbt Project
- Python Data Generation Scripts
- Data Quality Rules
- Power BI Dashboards
- Business Recommendations
- Future Enhancement Plan

---

# Professional Positioning

This project should always be represented as:

"An independent portfolio project inspired by real business workflows observed during my professional experience in the Healthcare Education domain. The solution was independently designed to demonstrate modern analytics engineering and business intelligence practices and was not implemented within my employer's systems."
