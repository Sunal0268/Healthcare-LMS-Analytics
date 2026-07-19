
"""
===========================================================
Generate Students Dataset
Project : Healthcare LMS Analytics
Author  : Sunal Singh
===========================================================

Output:
    ../Data/students.csv
"""

import random
from faker import Faker
import pandas as pd
from datetime import datetime, timedelta
from pathlib import Path


# -------------------------------------------------------
# Configuration
# -------------------------------------------------------

fake = Faker("en_IN")
random.seed(42)

TOTAL_STUDENTS = 50000

# -------------------------------------------------------
# Lookup Values
# -------------------------------------------------------

gender_list = [
    "Male",
    "Female",
    "Other"
]

education_levels = [
    "High School",
    "Diploma",
    "Graduate",
    "Post Graduate",
    "Doctorate"
]

occupations = [
    "Student",
    "Doctor",
    "Nurse",
    "Pharmacist",
    "Medical Officer",
    "Lab Technician",
    "Healthcare Administrator",
    "Physiotherapist",
    "Dentist",
    "Research Associate"
]

states = [
    "Maharashtra",
    "Delhi",
    "Karnataka",
    "Tamil Nadu",
    "Uttar Pradesh",
    "Gujarat",
    "Rajasthan",
    "Punjab",
    "Kerala",
    "Odisha",
    "West Bengal"
]

cities = {
    "Maharashtra": ["Mumbai","Pune","Nagpur"],
    "Delhi": ["New Delhi"],
    "Karnataka": ["Bengaluru","Mysuru"],
    "Tamil Nadu": ["Chennai","Coimbatore"],
    "Uttar Pradesh": ["Lucknow","Noida"],
    "Gujarat": ["Ahmedabad","Surat"],
    "Rajasthan": ["Jaipur","Udaipur"],
    "Punjab": ["Ludhiana","Amritsar"],
    "Kerala": ["Kochi","Thiruvananthapuram"],
    "Odisha": ["Bhubaneswar","Cuttack"],
    "West Bengal": ["Kolkata","Siliguri"]
}

# -------------------------------------------------------
# Generate Data
# -------------------------------------------------------

students = []

today = datetime.today()

for student_id in range(1, TOTAL_STUDENTS + 1):

    gender = random.choice(gender_list)

    if gender == "Male":
        first_name = fake.first_name_male()
    elif gender == "Female":
        first_name = fake.first_name_female()
    else:
        first_name = fake.first_name()

    last_name = fake.last_name()

    age = random.randint(18, 60)

    dob = today - timedelta(days=age * 365 + random.randint(0, 364))

    state = random.choice(states)

    city = random.choice(cities[state])

    registration_date = fake.date_between(
        start_date="-2y",
        end_date="today"
    )

    students.append({

        "student_id": student_id,

        "student_code": f"STU{student_id:06}",

        "first_name": first_name,

        "last_name": last_name,

        "gender": gender,

        "date_of_birth": dob.strftime("%Y-%m-%d"),

        "email": fake.unique.email(),

        "phone": fake.msisdn()[:10],

        "occupation": random.choice(occupations),

        "education_level": random.choice(education_levels),

        "state": state,

        "city": city,

        "registration_date": registration_date

    })



# -------------------------------------------------------
# Create DataFrame
# -------------------------------------------------------

df = pd.DataFrame(students)

# -------------------------------------------------------
# Save CSV
# -------------------------------------------------------

from pathlib import Path

# Get the project root directory
project_root = Path(__file__).resolve().parent.parent

# Create Data folder if it doesn't exist
data_folder = project_root / "Data"
data_folder.mkdir(exist_ok=True)

# Output file path
output_path = data_folder / "students.csv"

# Save CSV
df.to_csv(output_path, index=False)

# -------------------------------------------------------
# Success Message
# -------------------------------------------------------

print("=" * 60)
print("Students Dataset Generated Successfully")
print(f"Rows Generated : {len(df):,}")
print(f"Saved To       : {output_path}")
print("=" * 60)
