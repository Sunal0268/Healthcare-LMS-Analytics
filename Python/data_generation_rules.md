
# Data Generation Rules

- Total dataset size: 50,000 – 100,000 rows
- Time range: Last 24 months
- Country: India (primary)
- Age group: 18–60
- Courses: Healthcare domain only

## Business Rules

- One student can enroll in multiple courses
- Each enrollment has 1 campaign source
- Each course has 1 instructor
- Revenue = Course Price * (1 - discount)
- Completion rate depends on engagement


pip install pandas numpy faker