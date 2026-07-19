
"""
===========================================================
Generate Assessments Dataset
Healthcare LMS Analytics
Version 2.0

Author : Sunal Singh

Purpose
-------
Generate realistic assessment records
based on enrollment data.

Output
------
Data/assessments.csv
===========================================================
"""

import random
from pathlib import Path
from datetime import timedelta

import pandas as pd

random.seed(42)


# --------------------------------------------------------
# Configuration
# --------------------------------------------------------

ASSESSMENT_TYPES = [

    "Quiz",
    "Assignment",
    "Mid-Term",
    "Final Exam",
    "Practical"

]

STATUS = [

    "Completed",
    "Pending",
    "Missed"

]


# --------------------------------------------------------
# Read Enrollment Dataset
# --------------------------------------------------------

project_root = Path(__file__).resolve().parent.parent

data_folder = project_root / "Data"

enrollment_file = data_folder / "enrollments.csv"

enrollments = pd.read_csv(

    enrollment_file,

    parse_dates=[

        "enrollment_date",
        "completion_date"

    ]

)

print("=" * 60)
print("Enrollment Dataset Loaded")
print(f"Rows : {len(enrollments):,}")
print("=" * 60)


# --------------------------------------------------------
# Business Rules
# --------------------------------------------------------

def generate_assessment_count(progress):
    """
    Higher course progress generally results
    in more assessments being attempted.
    """

    if progress >= 100:
        return random.randint(3, 5)

    elif progress >= 70:
        return random.randint(2, 4)

    elif progress >= 40:
        return random.randint(1, 3)

    else:
        return random.randint(1, 2)


def generate_assessment_date(enrollment_date):
    """
    Assessment always happens
    after enrollment.
    """

    return enrollment_date + timedelta(
        days=random.randint(7, 180)
    )


def generate_status(progress):
    """
    Assessment status depends on
    student's course progress.
    """

    if progress >= 80:

        return random.choices(

            ["Completed", "Pending"],

            weights=[95, 5],

            k=1

        )[0]

    elif progress >= 40:

        return random.choices(

            ["Completed", "Pending", "Missed"],

            weights=[80, 15, 5],

            k=1

        )[0]

    else:

        return random.choices(

            ["Completed", "Pending", "Missed"],

            weights=[50, 25, 25],

            k=1

        )[0]


def generate_score(status):

    """
    Only completed assessments
    receive marks.
    """

    if status != "Completed":
        return None

    return random.randint(35, 100)


def generate_grade(score):

    """
    Grade based on score.
    """

    if score is None:
        return None

    if score >= 90:
        return "A+"

    elif score >= 80:
        return "A"

    elif score >= 70:
        return "B+"

    elif score >= 60:
        return "B"

    elif score >= 50:
        return "C"

    elif score >= 35:
        return "D"

    else:
        return "F"
    

# --------------------------------------------------------
# Generate Assessment Records
# --------------------------------------------------------

records = []

assessment_id = 1

for _, enrollment in enrollments.iterrows():

    enrollment_id = enrollment["enrollment_id"]

    student_id = enrollment["student_id"]

    course_id = enrollment["course_id"]

    enrollment_date = enrollment["enrollment_date"]

    progress = enrollment["progress_percent"]

    assessment_count = generate_assessment_count(
        progress
    )

    for _ in range(assessment_count):

        assessment_type = random.choice(
            ASSESSMENT_TYPES
        )

        assessment_date = generate_assessment_date(
            enrollment_date
        )

        status = generate_status(
            progress
        )

        score = generate_score(
            status
        )

        grade = generate_grade(
            score
        )

        records.append({

            "assessment_id": assessment_id,

            "enrollment_id": enrollment_id,

            "student_id": student_id,

            "course_id": course_id,

            "assessment_type": assessment_type,

            "assessment_date": assessment_date,

            "maximum_marks": 100,

            "score": score,

            "grade": grade,

            "status": status

        })

        assessment_id += 1



# --------------------------------------------------------
# Create DataFrame
# --------------------------------------------------------

df = pd.DataFrame(records)

# --------------------------------------------------------
# Data Quality Report
# --------------------------------------------------------

print("\n" + "=" * 60)
print("DATA QUALITY REPORT")
print("=" * 60)

print(f"Rows Generated : {len(df):,}")

print("\nDuplicate Assessment IDs")
print("-" * 60)
print(df["assessment_id"].duplicated().sum())

print("\nNull Values")
print("-" * 60)
print(df.isnull().sum())

print("\nAssessment Status Distribution")
print("-" * 60)
print(
    df["status"]
    .value_counts(normalize=True)
    .mul(100)
    .round(2)
)

print("\nAssessment Type Distribution")
print("-" * 60)
print(
    df["assessment_type"]
    .value_counts(normalize=True)
    .mul(100)
    .round(2)
)

print("\nGrade Distribution")
print("-" * 60)
print(
    df["grade"]
    .fillna("Not Available")
    .value_counts()
)

print("\nAverage Score")
print("-" * 60)
print(
    round(
        df["score"].mean(),
        2
    )
)

print("=" * 60)



# --------------------------------------------------------
# Enterprise Validation
# --------------------------------------------------------

print("\n" + "=" * 60)
print("ENTERPRISE VALIDATION")
print("=" * 60)

validation_results = []

# Unique Assessment IDs

validation_results.append((
    "Unique Assessment IDs",
    df["assessment_id"].duplicated().sum() == 0
))

# Score Range

validation_results.append((
    "Score Between 0 and 100",
    (
        df["score"].dropna().between(0, 100)
    ).all()
))

# Maximum Marks

validation_results.append((
    "Maximum Marks = 100",
    (df["maximum_marks"] == 100).all()
))

# Assessment Date

merged = df.merge(

    enrollments[
        [
            "enrollment_id",
            "enrollment_date"
        ]
    ],

    on="enrollment_id",

    how="left"

)

validation_results.append((
    "Assessment After Enrollment",
    (
        merged["assessment_date"] >=
        merged["enrollment_date"]
    ).all()
))

# Grade Logic

completed = df[df["status"] == "Completed"]

validation_results.append((
    "Completed Assessments Have Scores",
    completed["score"].notna().all()
))

# Print Results

passed = 0

for rule, status in validation_results:

    if status:

        passed += 1

        print(f"PASS | {rule}")

    else:

        print(f"FAIL | {rule}")

print("-" * 60)

print(
    f"Validation Passed : {passed}/{len(validation_results)}"
)

print("=" * 60)


# --------------------------------------------------------
# Export CSV
# --------------------------------------------------------

output_file = data_folder / "assessments.csv"

df.to_csv(

    output_file,

    index=False

)

print("\n" + "=" * 60)
print("ASSESSMENT DATASET GENERATED")
print("=" * 60)

print(f"Rows Generated : {len(df):,}")

print(f"Columns : {len(df.columns)}")

print(f"Saved To : {output_file}")

print("=" * 60)

