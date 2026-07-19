"""
===========================================================
Generate Revenue Dataset
Healthcare LMS Analytics
Version 2.0 (Enterprise Edition)

Author : Sunal Singh

Purpose
-------
Generate realistic revenue transactions directly from
Enrollment records.

Business Rules
--------------
✓ Revenue depends on Enrollment
✓ Invoice generated after enrollment
✓ Course pricing consistency
✓ Campaign based discounts
✓ GST calculation
✓ Refund simulation
✓ Payment status distribution

Output
------
Data/revenue.csv
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

GST_RATE = 18

PAID_WEIGHT = 88
PENDING_WEIGHT = 8
REFUNDED_WEIGHT = 4

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

# Fixed Course Price Catalog
# (Same course always has same base fee)

PRICE_OPTIONS = [
    499,
    799,
    999,
    1499,
    1999,
    2499,
    2999,
    3999,
    4999,
    5999
]

course_price_map = {}

for course_id in range(1, 121):

    course_price_map[course_id] = random.choice(
        PRICE_OPTIONS
    )


# --------------------------------------------------------
# Campaign Discount
# Better campaigns give better discounts
# --------------------------------------------------------

def get_discount_percent(campaign_id):

    if campaign_id <= 20:

        return random.choice([20,25,30])

    elif campaign_id <= 80:

        return random.choice([10,15,20])

    else:

        return random.choice([0,5,10])


# --------------------------------------------------------
# Payment Status
# --------------------------------------------------------

def get_payment_status():

    return random.choices(

        ["Paid","Pending","Refunded"],

        weights=[88,8,4],

        k=1

    )[0]


# --------------------------------------------------------
# Invoice Date
# Usually generated within 0–5 days
# after enrollment
# --------------------------------------------------------

def get_invoice_date(enrollment_date):

    days = random.randint(0,5)

    return enrollment_date + timedelta(days=days)


# --------------------------------------------------------
# GST
# --------------------------------------------------------

GST_RATE = 18

# --------------------------------------------------------
# Generate Revenue Records
# --------------------------------------------------------

records = []

for _, enrollment in enrollments.iterrows():

    # ----------------------------------------------------
    # IDs
    # ----------------------------------------------------

    revenue_id = enrollment["enrollment_id"]

    enrollment_id = enrollment["enrollment_id"]

    course_id = enrollment["course_id"]

    campaign_id = enrollment["campaign_id"]

    # ----------------------------------------------------
    # Course Price
    # ----------------------------------------------------

    course_fee = course_price_map[course_id]

    # ----------------------------------------------------
    # Discount
    # ----------------------------------------------------

    discount_percent = get_discount_percent(campaign_id)

    discount_amount = round(
        course_fee * discount_percent / 100,
        2
    )

    # ----------------------------------------------------
    # Tax
    # ----------------------------------------------------

    taxable_amount = course_fee - discount_amount

    tax_amount = round(
        taxable_amount * GST_RATE / 100,
        2
    )

    total_amount = round(
        taxable_amount + tax_amount,
        2
    )

    # ----------------------------------------------------
    # Payment
    # ----------------------------------------------------

    payment_status = get_payment_status()

    payment_method = random.choice([
        "UPI",
        "Credit Card",
        "Debit Card",
        "Net Banking",
        "Wallet"
    ])

    # ----------------------------------------------------
    # Refund Logic
    # ----------------------------------------------------

    if payment_status == "Paid":

        refund_amount = 0
        net_revenue = total_amount

    elif payment_status == "Pending":

        refund_amount = 0
        net_revenue = 0

    else:

        refund_amount = total_amount
        net_revenue = 0

    # ----------------------------------------------------
    # Invoice
    # ----------------------------------------------------

    invoice_date = get_invoice_date(
        enrollment["enrollment_date"]
    )

    invoice_number = f"INV{revenue_id:07d}"

    # ----------------------------------------------------
    # Store Record
    # ----------------------------------------------------

    records.append({

        "revenue_id": revenue_id,

        "enrollment_id": enrollment_id,

        "invoice_number": invoice_number,

        "invoice_date": invoice_date,

        "course_fee": course_fee,

        "discount_percent": discount_percent,

        "discount_amount": discount_amount,

        "tax_percent": GST_RATE,

        "tax_amount": tax_amount,

        "total_amount": total_amount,

        "payment_status": payment_status,

        "payment_method": payment_method,

        "refund_amount": refund_amount,

        "net_revenue": net_revenue,

        "currency": "INR"

    })


# --------------------------------------------------------
# Create DataFrame
# --------------------------------------------------------

df = pd.DataFrame(records)

# --------------------------------------------------------
# Data Quality Report
# --------------------------------------------------------

print("\n" + "=" * 70)
print("DATA QUALITY REPORT")
print("=" * 70)

# --------------------------------------------------------
# Row Count
# --------------------------------------------------------

print(f"Rows Generated : {len(df):,}")

# --------------------------------------------------------
# Duplicate Revenue IDs
# --------------------------------------------------------

duplicate_ids = df["revenue_id"].duplicated().sum()

print(f"Duplicate Revenue IDs : {duplicate_ids}")

# --------------------------------------------------------
# Null Value Summary
# --------------------------------------------------------

print("\nNull Value Summary")
print("-" * 70)

print(df.isnull().sum())

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
# Payment Method Distribution
# --------------------------------------------------------

print("\nPayment Method Distribution")
print("-" * 70)

payment_method_distribution = (

    df["payment_method"]

    .value_counts(normalize=True)

    .mul(100)

    .round(2)

)

print(payment_method_distribution)

# --------------------------------------------------------
# Revenue Summary
# --------------------------------------------------------

print("\nRevenue Summary")
print("-" * 70)

print(f"Total Revenue : ₹{df['total_amount'].sum():,.2f}")

print(f"Net Revenue   : ₹{df['net_revenue'].sum():,.2f}")

print(f"Refund Amount : ₹{df['refund_amount'].sum():,.2f}")

# --------------------------------------------------------
# Top 10 Revenue Courses
# --------------------------------------------------------

print("\nTop 10 Courses by Revenue")
print("-" * 70)

top_courses = (

    df.groupby("enrollment_id")["net_revenue"]

    .sum()

    .sort_values(ascending=False)

    .head(10)

)

print(top_courses)

# --------------------------------------------------------
# Monthly Revenue
# --------------------------------------------------------

print("\nMonthly Revenue")
print("-" * 70)

monthly_revenue = (

    df.assign(

        month=pd.to_datetime(df["invoice_date"]).dt.month_name()

    )

    .groupby("month")["net_revenue"]

    .sum()

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

monthly_revenue = monthly_revenue.reindex(month_order)

print(monthly_revenue)

print("=" * 70)

# --------------------------------------------------------
# Enterprise Validation Suite
# --------------------------------------------------------

print("\n" + "=" * 70)
print("ENTERPRISE VALIDATION SUITE")
print("=" * 70)

validation_results = []

# --------------------------------------------------------
# Unique Revenue IDs
# --------------------------------------------------------

duplicate_ids = df["revenue_id"].duplicated().sum()

validation_results.append(

    (

        "Unique Revenue IDs",

        duplicate_ids == 0,

        duplicate_ids

    )

)

# --------------------------------------------------------
# Net Revenue cannot exceed Total Amount
# --------------------------------------------------------

invalid_net = df[
    df["net_revenue"] > df["total_amount"]
]

validation_results.append(

    (

        "Net Revenue <= Total Amount",

        len(invalid_net) == 0,

        len(invalid_net)

    )

)

# --------------------------------------------------------
# Refund Amount cannot exceed Total Amount
# --------------------------------------------------------

invalid_refund = df[
    df["refund_amount"] > df["total_amount"]
]

validation_results.append(

    (

        "Refund <= Total Amount",

        len(invalid_refund) == 0,

        len(invalid_refund)

    )

)

# --------------------------------------------------------
# Pending Payments should have zero revenue
# --------------------------------------------------------

invalid_pending = df[

    (df["payment_status"] == "Pending") &

    (df["net_revenue"] != 0)

]

validation_results.append(

    (

        "Pending = Zero Revenue",

        len(invalid_pending) == 0,

        len(invalid_pending)

    )

)

# --------------------------------------------------------
# Refunded Payments should have zero revenue
# --------------------------------------------------------

invalid_refunded = df[

    (df["payment_status"] == "Refunded") &

    (df["net_revenue"] != 0)

]

validation_results.append(

    (

        "Refunded = Zero Revenue",

        len(invalid_refunded) == 0,

        len(invalid_refunded)

    )

)

# --------------------------------------------------------
# Paid Payments should have positive revenue
# --------------------------------------------------------

invalid_paid = df[

    (df["payment_status"] == "Paid") &

    (df["net_revenue"] <= 0)

]

validation_results.append(

    (

        "Paid = Positive Revenue",

        len(invalid_paid) == 0,

        len(invalid_paid)

    )

)

# --------------------------------------------------------
# Invoice Date should not be before Enrollment Date
# --------------------------------------------------------

validation_df = df.merge(

    enrollments[

        [

            "enrollment_id",

            "enrollment_date"

        ]

    ],

    on="enrollment_id",

    how="left"

)

invalid_invoice = validation_df[

    validation_df["invoice_date"] <

    validation_df["enrollment_date"]

]

validation_results.append(

    (

        "Invoice Date >= Enrollment Date",

        len(invalid_invoice) == 0,

        len(invalid_invoice)

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
# Prepare Export Dataset
# --------------------------------------------------------

df_export = df.drop(
    columns=["course_id"]
)

# --------------------------------------------------------
# Save CSV
# --------------------------------------------------------

output_file = data_folder / "revenue.csv"

df_export.to_csv(
    output_file,
    index=False
)

# --------------------------------------------------------
# Execution Summary
# --------------------------------------------------------

print("\n" + "=" * 70)
print("REVENUE DATASET GENERATED SUCCESSFULLY")
print("=" * 70)

print(f"Rows Generated      : {len(df_export):,}")
print(f"Columns Exported    : {len(df_export.columns)}")
print(f"Output File         : {output_file}")

print()

print(f"Gross Revenue       : ₹{df['total_amount'].sum():,.2f}")
print(f"Net Revenue         : ₹{df['net_revenue'].sum():,.2f}")
print(f"Refund Amount       : ₹{df['refund_amount'].sum():,.2f}")

print()

print("Payment Status")

print(df["payment_status"].value_counts())

print("=" * 70)