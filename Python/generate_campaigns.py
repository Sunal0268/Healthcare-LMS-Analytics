
"""
===========================================================
Generate Marketing Campaigns Dataset
Project : Healthcare LMS Analytics
Author  : Sunal Singh
===========================================================

Output:
    Data/campaigns.csv
"""

import random
import pandas as pd
from pathlib import Path
from faker import Faker
from datetime import timedelta

# -------------------------------------------------------
# Configuration
# -------------------------------------------------------

fake = Faker("en_IN")
random.seed(42)

TOTAL_CAMPAIGNS = 200

# -------------------------------------------------------
# Lookup Values
# -------------------------------------------------------

channels = [
    "Google Ads",
    "Facebook",
    "Instagram",
    "LinkedIn",
    "Email",
    "YouTube"
]

campaign_types = [
    "Brand Awareness",
    "Lead Generation",
    "Course Promotion",
    "Scholarship",
    "Webinar"
]

status = [
    "Completed",
    "Running",
    "Paused"
]

# -------------------------------------------------------
# Generate Dataset
# -------------------------------------------------------

campaigns = []

for campaign_id in range(1, TOTAL_CAMPAIGNS+1):

    start_date = fake.date_between(
        start_date="-2y",
        end_date="today"
    )

    duration = random.randint(15,90)

    end_date = start_date + timedelta(days=duration)

    budget = random.choice([
        10000,
        20000,
        30000,
        50000,
        75000,
        100000,
        150000
    ])

    leads = random.randint(100,5000)

    campaigns.append({

        "campaign_id": campaign_id,

        "campaign_code": f"CMP{campaign_id:04}",

        "campaign_name": f"{random.choice(campaign_types)} {campaign_id}",

        "campaign_type": random.choice(campaign_types),

        "marketing_channel": random.choice(channels),

        "start_date": start_date,

        "end_date": end_date,

        "budget": budget,

        "leads_generated": leads,

        "cost_per_lead": round(budget/leads,2),

        "campaign_status": random.choice(status)

    })

# -------------------------------------------------------
# DataFrame
# -------------------------------------------------------

df = pd.DataFrame(campaigns)

# -------------------------------------------------------
# Save CSV
# -------------------------------------------------------

project_root = Path(__file__).resolve().parent.parent

data_folder = project_root / "Data"
data_folder.mkdir(exist_ok=True)

output_path = data_folder / "campaigns.csv"

df.to_csv(output_path,index=False)

print("="*60)
print("Campaigns Dataset Generated Successfully")
print(f"Rows Generated : {len(df):,}")
print(f"Saved To       : {output_path}")
print("="*60)