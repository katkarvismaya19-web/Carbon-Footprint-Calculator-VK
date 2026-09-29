# Selenium Test Plan
# Carbon Footprint Calculator

## Critical User Journeys

### TC01 - Login
1. Open application
2. Enter valid email
3. Enter valid password
4. Click Login
5. Verify dashboard is displayed

Expected:
Dashboard loads and user name is displayed.

### TC02 - Add Carbon Activity
1. Login
2. Select Bus Travel
3. Enter 10
4. Submit
5. Verify new record appears

Expected:
10 km Bus Travel is stored with emission factor 0.1050.

### TC03 - Carbon Calculation
1. Add Bus Travel
2. Verify calculated emission

Expected:
10 × 0.1050 = 1.0500 kg CO2

### TC04 - Delete Record
1. Add test record
2. Click Delete
3. Verify record disappears

Expected:
Record is removed from dashboard and database.

### TC05 - Dashboard
1. Login
2. Open dashboard

Expected:
Total carbon emission and records are displayed.

## Quality Gate

All critical Selenium tests must pass before Docker deployment.
