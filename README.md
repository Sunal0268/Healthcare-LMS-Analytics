# Healthcare LMS Analytics Data Warehouse

> End-to-End Healthcare Learning Management System Analytics Solution built using PostgreSQL, Python, and Power BI following the Medallion Data Architecture.

---

# Project Overview

Healthcare organizations offering online certification and training programs generate large volumes of operational data, including student enrollments, assessments, instructor information, learning activities, campaigns, and revenue transactions.

This project demonstrates how raw healthcare LMS data can be transformed into meaningful business insights through a modern Data Warehouse and Business Intelligence solution.

The solution follows the **Medallion Architecture (Bronze → Silver → Gold)** to ensure scalable, maintainable, and analytics-ready data.

---

# Business Objectives

The project aims to answer key business questions such as:

- How many students are enrolled?
- Which course categories generate the highest revenue?
- What is the overall course completion rate?
- How are enrollments distributed over time?
- What is the payment status of enrolled students?
- How actively are students engaging with learning activities?
- How do instructors contribute to the learning ecosystem?
- What are the overall learner assessment outcomes?

---

# Solution Architecture

```
                CSV Files
                     │
                     ▼
          Bronze Layer (Raw Data)
                     │
                     ▼
      Silver Layer (Clean & Standardized)
                     │
                     ▼
       Gold Layer (Star Schema Model)
                     │
                     ▼
          PostgreSQL Data Warehouse
                     │
                     ▼
              Power BI Dashboards
```

*(Insert Architecture Diagram here)*

---

# Data Warehouse Design

The warehouse is designed using a **Star Schema** consisting of:

## Dimension Tables

- Student
- Course
- Instructor
- Campaign
- Institution
- Date

## Fact Tables

- Enrollment
- Revenue
- Assessment
- Learning Activity

The dimensional model enables efficient analytical reporting while minimizing query complexity.

*(Insert Star Schema image here)*

---

# ⚙️ Tech Stack

| Category | Technology |
|-----------|------------|
| Database | PostgreSQL |
| ETL | SQL |
| Data Generation | Python |
| Visualization | Power BI |
| Data Modeling | Star Schema |
| Architecture | Medallion Architecture |
| Documentation | Markdown |

---

# Executive Dashboard

The Executive Dashboard provides a high-level business overview of the Healthcare LMS.

### KPIs

- Total Enrollments
- Total Courses
- Total Instructors
- Total Campaigns
- Net Revenue
- Revenue per Student
- Revenue per Enrollment
- Total Refund Amount

### Business Insights

- Revenue Trend
- Enrollment Trend
- Revenue by Category
- Payment Status
- Course Completion Status
- Delivery Mode Distribution

*(Insert Dashboard Screenshot 1)*

---

# Learning Analytics Dashboard

The Learning Analytics Dashboard focuses on learner engagement and assessment performance.

### KPIs

- Total Students
- Average Score
- Assessment Completion
- Learning Hours
- Completed Learning Activities
- Course Completion Rate
- Average Instructor Rating

### Analytics

- Assessment Grade Distribution
- Assessment Status
- Device Usage
- Instructor Active Status
- Monthly Learning Activity Trend
- Instructor Experience Distribution

*(Insert Dashboard Screenshot 2)*

---

# Project Structure

```
Healthcare-LMS-Analytics
│
├── assets/
│
├── data/
│
├── docs/
│
├── powerbi/
│
├── python/
│
├── sql/
│
└── README.md
```

---

# Documentation

Detailed project documentation is available in the **docs** folder.

- Business Problem
- Business Entities
- Conceptual Data Model
- Logical Data Model
- Physical Data Model
- ER Diagram
- Star Schema
- Data Dictionary
- Data Modeling Walkthrough

---

# Key Features

✔ End-to-End Data Warehouse
✔ Medallion Architecture
✔ Star Schema Design
✔ SQL ETL Pipeline
✔ Synthetic Data Generation
✔ Interactive Power BI Dashboards
✔ Business KPI Development
✔ Dimensional Modeling

---

# Key Learnings

This project strengthened practical understanding of:

- Data Warehousing
- Dimensional Modeling
- Star Schema Design
- SQL-based ETL
- Business Intelligence Reporting
- KPI Development
- Dashboard Design
- Analytical Thinking

---

# Future Improvements

- Incremental Data Loading
- Automated ETL Scheduling
- dbt Integration
- Azure Data Factory Pipeline
- Power BI Service Deployment
- Row-Level Security
- Advanced DAX Optimization

---

# Author

**Sunal Singh**

Business Analyst | Data Analytics Enthusiast

- SQL
- Python
- Power BI
- Data Modelling
- Data Warehousing
- Business Intelligence

LinkedIn: *www.linkedin.com/in/sunalsingh*

---

## ⭐ If you found this project interesting, consider giving it a star.
