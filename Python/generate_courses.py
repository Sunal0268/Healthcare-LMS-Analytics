
"""
===========================================================
Generate Courses Dataset
Project : Healthcare LMS Analytics
Author  : Sunal Singh
===========================================================

Output:
    Data/courses.csv
"""

import random
import pandas as pd
from pathlib import Path
from faker import Faker

# -------------------------------------------------------
# Configuration
# -------------------------------------------------------

fake = Faker("en_IN")
random.seed(42)

TOTAL_COURSES = 120

# -------------------------------------------------------
# Lookup Values
# -------------------------------------------------------

categories = [
    "Clinical",
    "Nursing",
    "Pharmacy",
    "Public Health",
    "Medical Coding",
    "Healthcare Management",
    "Laboratory",
    "Emergency Care"
]

difficulty = [
    "Beginner",
    "Intermediate",
    "Advanced"
]

delivery_mode = [
    "Self-paced",
    "Instructor-led",
    "Hybrid"
]

course_status = [
    "Active",
    "Active",
    "Active",
    "Archived"
]

# -------------------------------------------------------
# Generate Dataset
# -------------------------------------------------------

courses = []

for course_id in range(1, TOTAL_COURSES + 1):

    category = random.choice(categories)

    duration = random.choice([4,6,8,10,12,16])

    fee = random.choice([
        1999,
        2999,
        3999,
        4999,
        5999,
        7999,
        9999,
        12999
    ])

    courses.append({

        "course_id": course_id,

        "course_code": f"CRS{course_id:04}",

        "course_name": f"{category} Certification {course_id}",

        "category": category,

        "difficulty_level": random.choice(difficulty),

        "duration_weeks": duration,

        "delivery_mode": random.choice(delivery_mode),

        "course_fee": fee,

        "certificate_available": random.choice(["Yes","No"]),

        "course_status": random.choice(course_status)

    })

# -------------------------------------------------------
# DataFrame
# -------------------------------------------------------

df = pd.DataFrame(courses)

# -------------------------------------------------------
# Save CSV
# -------------------------------------------------------

project_root = Path(__file__).resolve().parent.parent

data_folder = project_root / "Data"
data_folder.mkdir(exist_ok=True)

output_path = data_folder / "courses.csv"

df.to_csv(output_path,index=False)

print("="*60)
print("Courses Dataset Generated Successfully")
print(f"Rows Generated : {len(df):,}")
print(f"Saved To       : {output_path}")
print("="*60)