"""
===========================================================
Generate Enrollments Dataset
Healthcare LMS Analytics
Version 2.0 (Enterprise Edition)

Author  : Sunal Singh
Purpose :
    Generate realistic enrollment data for a Healthcare
    Learning Management System using business-driven logic.

Features
--------
✓ Admission seasonality
✓ 80/20 course popularity
✓ Instructor popularity
✓ Campaign effectiveness
✓ Progress based on enrollment age
✓ Realistic completion behaviour
✓ Weighted payment distribution

Output
------
Data/enrollments.csv
===========================================================
"""

import random
import calendar
from datetime import date
from pathlib import Path

import pandas as pd
from faker import Faker

# --------------------------------------------------------
# Configuration
# --------------------------------------------------------

fake = Faker("en_IN")

random.seed(42)
Faker.seed(42)

TODAY = date.today()

TOTAL_ENROLLMENTS = 100000
TOTAL_STUDENTS = 50000
TOTAL_COURSES = 120
TOTAL_INSTRUCTORS = 300
TOTAL_CAMPAIGNS = 200

# --------------------------------------------------------
# Admission Seasonality
# Higher admissions during Jun–Sep
# --------------------------------------------------------

MONTH_WEIGHTS = {

    1: 4,
    2: 5,
    3: 7,
    4: 8,
    5: 10,
    6: 13,
    7: 16,
    8: 18,
    9: 14,
    10: 9,
    11: 5,
    12: 3

}

# --------------------------------------------------------
# Course Popularity (80/20 Rule)
# --------------------------------------------------------

COURSE_IDS = list(range(1, TOTAL_COURSES + 1))

COURSE_WEIGHTS = []

for course in COURSE_IDS:

    if course <= 10:

        COURSE_WEIGHTS.append(40)

    elif course <= 30:

        COURSE_WEIGHTS.append(18)

    elif course <= 60:

        COURSE_WEIGHTS.append(8)

    else:

        COURSE_WEIGHTS.append(2)

# --------------------------------------------------------
# Instructor Popularity
# --------------------------------------------------------

INSTRUCTOR_IDS = list(range(1, TOTAL_INSTRUCTORS + 1))

INSTRUCTOR_WEIGHTS = []

for instructor in INSTRUCTOR_IDS:

    if instructor <= 30:

        INSTRUCTOR_WEIGHTS.append(18)

    elif instructor <= 100:

        INSTRUCTOR_WEIGHTS.append(8)

    else:

        INSTRUCTOR_WEIGHTS.append(2)

# --------------------------------------------------------
# Campaign Performance
# --------------------------------------------------------

CAMPAIGN_IDS = list(range(1, TOTAL_CAMPAIGNS + 1))

CAMPAIGN_WEIGHTS = []

for campaign in CAMPAIGN_IDS:

    if campaign <= 20:

        CAMPAIGN_WEIGHTS.append(30)

    elif campaign <= 80:

        CAMPAIGN_WEIGHTS.append(10)

    else:

        CAMPAIGN_WEIGHTS.append(2)

# --------------------------------------------------------
# Helper Functions
# --------------------------------------------------------

def weighted_choice(population, weights):
    """
    Returns one weighted random value.
    """

    return random.choices(
        population,
        weights=weights,
        k=1
    )[0]


def generate_enrollment_date():
    """
    Generate enrollment date using
    academic seasonality.
    """

    year = random.choice([2024, 2025, 2026])

    month = weighted_choice(

        list(MONTH_WEIGHTS.keys()),

        list(MONTH_WEIGHTS.values())

    )

    last_day = calendar.monthrange(year, month)[1]

    day = random.randint(1, last_day)

    return date(year, month, day)


def calculate_progress(days_since):
    """
    Progress increases as enrollment gets older.
    """

    if days_since <= 30:

        return random.randint(0, 20)

    elif days_since <= 90:

        return random.randint(20, 50)

    elif days_since <= 180:

        return random.randint(45, 75)

    elif days_since <= 365:

        return random.randint(70, 95)

    return random.randint(90, 100)


def determine_payment_status():
    """
    Realistic payment distribution.
    """

    return random.choices(

        ["Paid", "Pending", "Refunded"],

        weights=[88, 8, 4],

        k=1

    )[0]


# --------------------------------------------------------
# Enrollment Business Logic
# --------------------------------------------------------

def determine_course_status(progress):
    """
    Decide course status
    based on progress.
    """

    if progress == 100:

        return "Completed"

    elif progress >= 50:

        return "In Progress"

    elif progress >= 15:

        if random.random() < 0.12:

            return "Dropped"

        return "In Progress"

    else:

        if random.random() < 0.25:

            return "Dropped"

        return "Not Started"


def determine_completion_date(
    enrollment_date,
    course_status
):
    """
    Completion date exists
    only for completed courses.
    """

    if course_status != "Completed":

        return None

    completion_gap = random.randint(15, 240)

    completion_date = enrollment_date + pd.Timedelta(
        days=completion_gap
    )

    if completion_date > TODAY:

        completion_date = TODAY

    return completion_date


# --------------------------------------------------------
# Generate Enrollment Records
# --------------------------------------------------------

records = []

for enrollment_id in range(1, TOTAL_ENROLLMENTS + 1):

    # --------------------------------------------
    # Student
    # --------------------------------------------

    student_id = random.randint(
        1,
        TOTAL_STUDENTS
    )

    # --------------------------------------------
    # Course (Weighted)
    # --------------------------------------------

    course_id = weighted_choice(
        COURSE_IDS,
        COURSE_WEIGHTS
    )

    # --------------------------------------------
    # Instructor (Weighted)
    # --------------------------------------------

    instructor_id = weighted_choice(
        INSTRUCTOR_IDS,
        INSTRUCTOR_WEIGHTS
    )

    # --------------------------------------------
    # Campaign (Weighted)
    # --------------------------------------------

    campaign_id = weighted_choice(
        CAMPAIGN_IDS,
        CAMPAIGN_WEIGHTS
    )

    # --------------------------------------------
    # Enrollment Date
    # --------------------------------------------

    enrollment_date = generate_enrollment_date()

    # --------------------------------------------
    # Days Since Enrollment
    # --------------------------------------------

    days_since = (
        TODAY -
        enrollment_date
    ).days

    # --------------------------------------------
    # Learning Progress
    # --------------------------------------------

    progress = calculate_progress(
        days_since
    )

    # --------------------------------------------
    # Course Status
    # --------------------------------------------

    course_status = determine_course_status(
        progress
    )

    # --------------------------------------------
    # Completion Date
    # --------------------------------------------

    completion_date = determine_completion_date(
        enrollment_date,
        course_status
    )

    # --------------------------------------------
    # Payment Status
    # --------------------------------------------

    payment_status = determine_payment_status()

    # --------------------------------------------
    # Store Record
    # --------------------------------------------

    records.append({

        "enrollment_id": enrollment_id,

        "student_id": student_id,

        "course_id": course_id,

        "instructor_id": instructor_id,

        "campaign_id": campaign_id,

        "enrollment_date": enrollment_date,

        "completion_date": completion_date,

        "progress_percent": progress,

        "course_status": course_status,

        "payment_status": payment_status

    })



# --------------------------------------------------------
# Create DataFrame
# --------------------------------------------------------

df = pd.DataFrame(records)

# --------------------------------------------------------
# Data Quality Checks
# --------------------------------------------------------

print("\n" + "=" * 70)
print("DATA QUALITY REPORT")
print("=" * 70)

# --------------------------------------------------------
# Row Count
# --------------------------------------------------------

print(f"Rows Generated : {len(df):,}")

# --------------------------------------------------------
# Duplicate Enrollment IDs
# --------------------------------------------------------

duplicate_ids = df["enrollment_id"].duplicated().sum()

print(f"Duplicate Enrollment IDs : {duplicate_ids}")

# --------------------------------------------------------
# Null Values
# --------------------------------------------------------

print("\nNull Value Summary")

print("-" * 70)

print(df.isnull().sum())

# --------------------------------------------------------
# Course Status Distribution
# --------------------------------------------------------

print("\nCourse Status Distribution")

print("-" * 70)

status_distribution = (

    df["course_status"]

    .value_counts(normalize=True)

    .mul(100)

    .round(2)

)

print(status_distribution)

# --------------------------------------------------------
# Payment Status Distribution
# --------------------------------------------------------

print("\nPayment Status Distribution")

print("-" * 70)

payment_distribution = (

    df["payment_status"]

    .value_counts(normalize=True)

    .mul(100)

    .round(2)

)

print(payment_distribution)

# --------------------------------------------------------
# Completion Rate
# --------------------------------------------------------

completion_rate = (

    (df["course_status"] == "Completed")

    .mean()

    * 100

)

print("\nCompletion Rate")

print("-" * 70)

print(f"{completion_rate:.2f}%")

# --------------------------------------------------------
# Top 10 Courses
# --------------------------------------------------------

print("\nTop 10 Courses")

print("-" * 70)

top_courses = (

    df["course_id"]

    .value_counts()

    .head(10)

)

print(top_courses)

# --------------------------------------------------------
# Top 10 Campaigns
# --------------------------------------------------------

print("\nTop 10 Campaigns")

print("-" * 70)

top_campaigns = (

    df["campaign_id"]

    .value_counts()

    .head(10)

)

print(top_campaigns)

# --------------------------------------------------------
# Top 10 Instructors
# --------------------------------------------------------

print("\nTop 10 Instructors")

print("-" * 70)

top_instructors = (

    df["instructor_id"]

    .value_counts()

    .head(10)

)

print(top_instructors)

# --------------------------------------------------------
# Monthly Enrollment Distribution
# --------------------------------------------------------

print("\nMonthly Distribution")

print("-" * 70)

monthly_distribution = (

    pd.to_datetime(df["enrollment_date"])

    .dt.month_name()

    .value_counts()

)

month_order = [

    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"

]

monthly_distribution = (

    monthly_distribution

    .reindex(month_order)

)

print(monthly_distribution)

print("=" * 70)


# --------------------------------------------------------
# Enterprise Validation Suite
# --------------------------------------------------------

print("\n" + "=" * 70)
print("ENTERPRISE VALIDATION SUITE")
print("=" * 70)

validation_results = []

# --------------------------------------------------------
# Validation 1
# Enrollment IDs must be unique
# --------------------------------------------------------

duplicate_count = df["enrollment_id"].duplicated().sum()

validation_results.append(

    (
        "Unique Enrollment IDs",
        duplicate_count == 0,
        duplicate_count
    )

)

# --------------------------------------------------------
# Validation 2
# Completed courses must have completion date
# --------------------------------------------------------

invalid_completed = df[
    (df["course_status"] == "Completed") &
    (df["completion_date"].isna())
]

validation_results.append(

    (
        "Completed Courses Have Completion Date",
        len(invalid_completed) == 0,
        len(invalid_completed)
    )

)

# --------------------------------------------------------
# Validation 3
# Non-completed courses must NOT have completion date
# --------------------------------------------------------

invalid_dates = df[
    (df["course_status"] != "Completed") &
    (df["completion_date"].notna())
]

validation_results.append(

    (
        "Only Completed Courses Have Completion Date",
        len(invalid_dates) == 0,
        len(invalid_dates)
    )

)

# --------------------------------------------------------
# Validation 4
# Completed must have 100% progress
# --------------------------------------------------------

invalid_progress = df[
    (df["course_status"] == "Completed") &
    (df["progress_percent"] != 100)
]

validation_results.append(

    (
        "Completed Progress = 100%",
        len(invalid_progress) == 0,
        len(invalid_progress)
    )

)

# --------------------------------------------------------
# Validation 5
# Progress cannot exceed 100
# --------------------------------------------------------

progress_limit = df[
    df["progress_percent"] > 100
]

validation_results.append(

    (
        "Progress <= 100",
        len(progress_limit) == 0,
        len(progress_limit)
    )

)

# --------------------------------------------------------
# Validation 6
# Progress cannot be negative
# --------------------------------------------------------

negative_progress = df[
    df["progress_percent"] < 0
]

validation_results.append(

    (
        "Progress >= 0",
        len(negative_progress) == 0,
        len(negative_progress)
    )

)

# --------------------------------------------------------
# Validation 7
# Valid Payment Status
# --------------------------------------------------------

valid_payment = [

    "Paid",
    "Pending",
    "Refunded"

]

payment_check = df[
    ~df["payment_status"].isin(valid_payment)
]

validation_results.append(

    (
        "Valid Payment Status",
        len(payment_check) == 0,
        len(payment_check)
    )

)

# --------------------------------------------------------
# Validation 8
# Valid Course Status
# --------------------------------------------------------

valid_status = [

    "Completed",
    "In Progress",
    "Dropped",
    "Not Started"

]

status_check = df[
    ~df["course_status"].isin(valid_status)
]

validation_results.append(

    (
        "Valid Course Status",
        len(status_check) == 0,
        len(status_check)
    )

)

# --------------------------------------------------------
# Print Results
# --------------------------------------------------------

passed = 0

for rule, status, errors in validation_results:

    if status:

        passed += 1

        print(f"PASS | {rule}")

    else:

        print(f"FAIL | {rule} | Errors : {errors}")

print("-" * 70)

print(f"Passed : {passed}/{len(validation_results)}")

if passed == len(validation_results):

    print("Dataset Validation : SUCCESS")

else:

    print("Dataset Validation : FAILED")

print("=" * 70)


# --------------------------------------------------------
# Save Dataset
# --------------------------------------------------------

project_root = Path(__file__).resolve().parent.parent

data_folder = project_root / "Data"

data_folder.mkdir(exist_ok=True)

output_path = data_folder / "enrollments.csv"

df.to_csv(
    output_path,
    index=False
)

# --------------------------------------------------------
# Execution Summary
# --------------------------------------------------------

print("\n" + "=" * 70)
print("ENROLLMENT DATASET GENERATED SUCCESSFULLY")
print("=" * 70)

print(f"Rows Generated      : {len(df):,}")
print(f"Columns             : {len(df.columns)}")
print(f"Output File         : {output_path}")

print("=" * 70)