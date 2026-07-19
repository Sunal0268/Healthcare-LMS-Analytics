
"""
===========================================================
Generate Learning Activity Dataset
Healthcare LMS Analytics
Version 2.0 (Enterprise Edition)

Author : Sunal Singh

Purpose
-------
Generate realistic student learning activities
based on enrollment records.

Business Rules
--------------
✓ Activities generated from enrollments
✓ Activity dates after enrollment
✓ Multiple learning events per student
✓ Realistic progress updates
✓ Device usage simulation

Output
------
Data/learning_activity.csv
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

MIN_ACTIVITIES = 1
MAX_ACTIVITIES = 6

DEVICES = [
    "Desktop",
    "Mobile",
    "Tablet"
]

ACTIVITY_TYPES = [

    "Course Login",
    "Video Watched",
    "Quiz Attempt",
    "Assignment Submission",
    "Discussion"

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

print("="*60)
print("Enrollment Dataset Loaded")
print(f"Rows : {len(enrollments):,}")
print("="*60)

# --------------------------------------------------------
# Business Rules
# --------------------------------------------------------

def generate_activity_count(progress):

    """
    Higher course progress generally
    means more learning activities.
    """

    if progress >= 100:
        return random.randint(4, 6)

    elif progress >= 70:
        return random.randint(3, 5)

    elif progress >= 40:
        return random.randint(2, 4)

    else:
        return random.randint(1, 3)


def generate_activity_date(enrollment_date):

    """
    Activity always happens
    after enrollment.
    """

    return enrollment_date + timedelta(
        days=random.randint(0, 180)
    )


def generate_duration(activity_type):

    """
    Different activities take
    different amounts of time.
    """

    if activity_type == "Course Login":
        return random.randint(2, 10)

    elif activity_type == "Video Watched":
        return random.randint(10, 60)

    elif activity_type == "Quiz Attempt":
        return random.randint(10, 30)

    elif activity_type == "Assignment Submission":
        return random.randint(20, 90)

    else:   # Discussion
        return random.randint(5, 25)


def generate_progress(previous_progress):

    """
    Progress gradually increases
    over time.
    """

    increase = random.randint(5, 25)

    return min(
        previous_progress + increase,
        100
    )


# --------------------------------------------------------
# Generate Learning Activities
# --------------------------------------------------------

records = []

activity_id = 1

for _, enrollment in enrollments.iterrows():

    student_id = enrollment["student_id"]
    course_id = enrollment["course_id"]
    enrollment_id = enrollment["enrollment_id"]
    enrollment_date = enrollment["enrollment_date"]

    current_progress = 0

    activity_count = generate_activity_count(
        enrollment["progress_percent"]
    )

    for _ in range(activity_count):

        activity_type = random.choice(ACTIVITY_TYPES)

        activity_date = generate_activity_date(
            enrollment_date
        )

        current_progress = generate_progress(
            current_progress
        )

        records.append({

            "activity_id": activity_id,

            "enrollment_id": enrollment_id,

            "student_id": student_id,

            "course_id": course_id,

            "activity_date": activity_date,

            "activity_type": activity_type,

            "duration_minutes": generate_duration(
                activity_type
            ),

            "progress_percent": current_progress,

            "completed": current_progress >= 100,

            "device": random.choice(DEVICES)

        })

        activity_id += 1

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

print("\nDuplicate Activity IDs")
print("-" * 60)
print(df["activity_id"].duplicated().sum())

print("\nNull Values")
print("-" * 60)
print(df.isnull().sum())

print("\nActivity Type Distribution")
print("-" * 60)
print(
    df["activity_type"]
    .value_counts(normalize=True)
    .mul(100)
    .round(2)
)

print("\nDevice Distribution")
print("-" * 60)
print(
    df["device"]
    .value_counts(normalize=True)
    .mul(100)
    .round(2)
)

print("\nAverage Duration")
print("-" * 60)
print(
    round(
        df["duration_minutes"].mean(),
        2
    ),
    "minutes"
)

print("\nCompleted Activities")
print("-" * 60)
print(
    df["completed"]
    .value_counts()
)

print("=" * 60)


# --------------------------------------------------------
# Enterprise Validation
# --------------------------------------------------------

print("\n" + "=" * 60)
print("ENTERPRISE VALIDATION")
print("=" * 60)

validation_results = []

# Unique Activity IDs

validation_results.append((
    "Unique Activity IDs",
    df["activity_id"].duplicated().sum() == 0
))

# Progress Range

validation_results.append((
    "Progress Between 0-100",
    (
        (df["progress_percent"] >= 0) &
        (df["progress_percent"] <= 100)
    ).all()
))

# Positive Duration

validation_results.append((
    "Positive Duration",
    (df["duration_minutes"] > 0).all()
))

# Activity Date >= Enrollment Date

merged = df.merge(

    enrollments[[
        "enrollment_id",
        "enrollment_date"
    ]],

    on="enrollment_id",
    how="left"

)

validation_results.append((
    "Activity After Enrollment",
    (
        merged["activity_date"] >=
        merged["enrollment_date"]
    ).all()
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

output_file = data_folder / "learning_activity.csv"

df.to_csv(

    output_file,

    index=False

)

print("\n" + "=" * 60)
print("LEARNING ACTIVITY DATASET GENERATED")
print("=" * 60)

print(f"Rows Generated : {len(df):,}")

print(f"Columns : {len(df.columns)}")

print(f"Saved To : {output_file}")

print("=" * 60)


