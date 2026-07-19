
"""
===========================================================
Generate Institutions Dataset
Project : Healthcare LMS Analytics
Author  : Sunal Singh
===========================================================

Output:
    Data/institutions.csv
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

TOTAL_INSTITUTIONS = 250

# -------------------------------------------------------
# Lookup Values
# -------------------------------------------------------

institution_types = [
    "Medical College",
    "Hospital",
    "University",
    "Nursing College",
    "Pharmacy College",
    "Training Institute"
]

ownership = [
    "Government",
    "Private",
    "Trust"
]

states = [
    "Maharashtra",
    "Delhi",
    "Karnataka",
    "Tamil Nadu",
    "Gujarat",
    "Kerala",
    "Punjab",
    "Rajasthan",
    "West Bengal",
    "Odisha"
]

cities = {
    "Maharashtra":["Mumbai","Pune","Nagpur"],
    "Delhi":["New Delhi"],
    "Karnataka":["Bengaluru","Mysuru"],
    "Tamil Nadu":["Chennai","Coimbatore"],
    "Gujarat":["Ahmedabad","Surat"],
    "Kerala":["Kochi","Thiruvananthapuram"],
    "Punjab":["Amritsar","Ludhiana"],
    "Rajasthan":["Jaipur","Udaipur"],
    "West Bengal":["Kolkata","Siliguri"],
    "Odisha":["Bhubaneswar","Cuttack"]
}

# -------------------------------------------------------
# Generate Dataset
# -------------------------------------------------------

institutions = []

for institution_id in range(1, TOTAL_INSTITUTIONS + 1):

    state = random.choice(states)

    institutions.append({

        "institution_id": institution_id,

        "institution_code": f"INS{institution_id:04}",

        "institution_name": fake.company() + " Healthcare Institute",

        "institution_type": random.choice(institution_types),

        "ownership": random.choice(ownership),

        "state": state,

        "city": random.choice(cities[state]),

        "established_year": random.randint(1980,2025),

        "accreditation": random.choice([
            "NAAC A+",
            "NAAC A",
            "NMC Approved",
            "PCI Approved",
            "State Approved"
        ])

    })

# -------------------------------------------------------
# DataFrame
# -------------------------------------------------------

df = pd.DataFrame(institutions)

# -------------------------------------------------------
# Save CSV
# -------------------------------------------------------

project_root = Path(__file__).resolve().parent.parent
data_folder = project_root / "Data"
data_folder.mkdir(exist_ok=True)

output_path = data_folder / "institutions.csv"

df.to_csv(output_path,index=False)

print("="*60)
print("Institutions Dataset Generated Successfully")
print(f"Rows Generated : {len(df):,}")
print(f"Saved To       : {output_path}")
print("="*60)