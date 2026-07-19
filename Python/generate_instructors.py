
"""
===========================================================
Generate Instructors Dataset
Project : Healthcare LMS Analytics
Author  : Sunal Singh
===========================================================

Output:
    Data/instructors.csv
"""

import random
import pandas as pd
from faker import Faker
from pathlib import Path
from datetime import datetime

# -------------------------------------------------------
# Configuration
# -------------------------------------------------------

fake = Faker("en_IN")
random.seed(42)

TOTAL_INSTRUCTORS = 500

# -------------------------------------------------------
# Lookup Values
# -------------------------------------------------------

genders = [
    "Male",
    "Female"
]

specializations = [
    "Cardiology",
    "Neurology",
    "Radiology",
    "Oncology",
    "Orthopedics",
    "Pediatrics",
    "Emergency Medicine",
    "Critical Care",
    "Pharmacology",
    "Nursing",
    "Medical Coding",
    "Healthcare Management",
    "Clinical Research",
    "Public Health",
    "Medical Laboratory"
]

qualifications = [
    "MBBS",
    "MD",
    "MS",
    "MDS",
    "BDS",
    "B.Sc Nursing",
    "M.Sc Nursing",
    "PharmD",
    "MBA Healthcare",
    "PhD"
]

experience_levels = [
    "0-2 Years",
    "3-5 Years",
    "6-10 Years",
    "11-15 Years",
    "15+ Years"
]

states = [
    "Maharashtra",
    "Delhi",
    "Karnataka",
    "Tamil Nadu",
    "Kerala",
    "Punjab",
    "Gujarat",
    "Rajasthan",
    "West Bengal",
    "Odisha"
]

cities = {
    "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
    "Delhi": ["New Delhi"],
    "Karnataka": ["Bengaluru", "Mysuru"],
    "Tamil Nadu": ["Chennai", "Coimbatore"],
    "Kerala": ["Kochi", "Thiruvananthapuram"],
    "Punjab": ["Amritsar", "Ludhiana"],
    "Gujarat": ["Ahmedabad", "Surat"],
    "Rajasthan": ["Jaipur", "Udaipur"],
    "West Bengal": ["Kolkata", "Siliguri"],
    "Odisha": ["Bhubaneswar", "Cuttack"]
}

employment_types = [
    "Full-Time",
    "Part-Time",
    "Visiting Faculty"
]

# -------------------------------------------------------
# Generate Dataset
# -------------------------------------------------------

instructors = []

for instructor_id in range(1, TOTAL_INSTRUCTORS + 1):

    gender = random.choice(genders)

    if gender == "Male":
        first_name = fake.first_name_male()
    else:
        first_name = fake.first_name_female()

    last_name = fake.last_name()

    state = random.choice(states)
    city = random.choice(cities[state])

    joining_date = fake.date_between(
        start_date="-10y",
        end_date="today"
    )

    instructors.append({

        "instructor_id": instructor_id,

        "instructor_code": f"INS{instructor_id:05}",

        "first_name": first_name,

        "last_name": last_name,

        "gender": gender,

        "email": fake.unique.email(),

        "phone": fake.msisdn()[:10],

        "qualification": random.choice(qualifications),

        "specialization": random.choice(specializations),

        "experience_level": random.choice(experience_levels),

        "employment_type": random.choice(employment_types),

        "state": state,

        "city": city,

        "joining_date": joining_date,

        "rating": round(random.uniform(3.5, 5.0), 1),

        "active_status": random.choice([
            "Active",
            "Active",
            "Active",
            "Inactive"
        ])

    })

# -------------------------------------------------------
# Create DataFrame
# -------------------------------------------------------

df = pd.DataFrame(instructors)

# -------------------------------------------------------
# Save CSV
# -------------------------------------------------------

project_root = Path(__file__).resolve().parent.parent

data_folder = project_root / "Data"
data_folder.mkdir(exist_ok=True)

output_path = data_folder / "instructors.csv"

df.to_csv(output_path, index=False)

# -------------------------------------------------------
# Success Message
# -------------------------------------------------------

print("=" * 60)
print("Instructors Dataset Generated Successfully")
print(f"Rows Generated : {len(df):,}")
print(f"Saved To       : {output_path}")
print("=" * 60)