# Week 2 – Agile Planning & DevOps Workflow

## 1. Product Backlog

| ID | Task | Priority | Status |
|---|---|---|---|
| P01 | Design Carbon Footprint Calculator UI | High | To Do |
| P02 | Add transportation input | High | To Do |
| P03 | Add electricity consumption input | High | To Do |
| P04 | Implement carbon emission calculation | High | To Do |
| P05 | Display total carbon footprint | High | To Do |
| P06 | Add carbon reduction suggestions | Medium | To Do |
| P07 | Add input validation | High | To Do |
| P08 | Set up Git/GitHub repository | High | To Do |
| P09 | Configure Jenkins | High | To Do |
| P10 | Create Jenkins CI pipeline | High | To Do |
| P11 | Add automated testing | High | To Do |
| P12 | Configure automated deployment | High | To Do |
| P13 | Perform end-to-end testing | High | To Do |
| P14 | Prepare project documentation | Medium | To Do |
| P15 | Prepare final presentation and demonstration | Medium | 
## 2. User Stories

### US01 – Transportation Input
As a user, I want to enter my transportation details so that I can calculate my transportation-related carbon emissions.

### US02 – Electricity Input
As a user, I want to enter my electricity consumption so that I can calculate my energy-related carbon emissions.

### US03 – Carbon Footprint Calculation
As a user, I want the system to calculate my total carbon footprint automatically so that I can understand my environmental impact.

### US04 – View Carbon Footprint Result
As a user, I want to view my carbon footprint result clearly so that I can understand my estimated emissions.

### US05 – Reduction Suggestions
As a user, I want to receive suggestions for reducing my carbon emissions so that I can adopt more sustainable practices.

### US06 – GitHub Repository
As a developer, I want to store the application source code in GitHub so that project changes can be tracked and managed.

### US07 – Automated Build
As a developer, I want Jenkins to automatically build the application so that manual build operations are reduced.

### US08 – Automated Testing
As a developer, I want Jenkins to run automated tests so that application errors can be detected before deployment.

### US09 – Automated Deployment
As a developer, I want Jenkins to automatically deploy a successful build so that the latest version of the application can be delivered quickly.

### US10 – Build and Deployment Status
As an administrator, I want to view Jenkins build and deployment status so that successful and failed pipeline executions can be identified.
## 3. Acceptance Criteria

### US01 – Transportation Input
- User can enter transportation details.
- Required fields are validated.
- Invalid input is rejected.
- Valid input is used in the carbon emission calculation.

### US02 – Electricity Input
- User can enter electricity consumption.
- Required fields are validated.
- Valid electricity data is used in the calculation.

### US03 – Carbon Footprint Calculation
- System accepts valid user input.
- Predefined emission factors are applied.
- Carbon emissions are calculated correctly.
- Total estimated carbon footprint is displayed.

### US04 – View Carbon Footprint Result
- The calculated result is displayed clearly.
- The user can understand the estimated carbon footprint.
- The result is displayed without calculation errors.

### US05 – Reduction Suggestions
- The system displays basic suggestions after calculation.
- Suggestions are relevant to reducing carbon emissions.

### US06 – GitHub Repository
- Project source code is stored in GitHub.
- Changes can be committed and tracked.
- Required project files are maintained in the repository.

### US07 – Automated Build
- Jenkins can connect to the project repository.
- Jenkins retrieves the latest source code.
- The application build completes successfully.

### US08 – Automated Testing
- Jenkins executes the defined tests.
- Test results are recorded.
- Failed tests are reported by the pipeline.

### US09 – Automated Deployment
- A successful build can be deployed automatically.
- The deployed application can be accessed.
- Failed builds are not deployed.

### US10 – Build and Deployment Status
- Jenkins displays pipeline status.
- Successful and failed executions can be identified.
## 4. 15-Week Agile Plan

| Week | Planned Work |
|---|---|
| 1 | Problem Definition and Scope |
| 2 | Agile Planning and DevOps Workflow |
| 3 | Requirements, Architecture and Technology Setup |
| 4 | UI/UX Design and Project Structure |
| 5 | Frontend Development |
| 6 | Backend and Carbon Calculation Logic |
| 7 | Integration and Input Validation |
| 8 | Testing and Bug Fixing |
| 9 | Git/GitHub Workflow |
| 10 | Jenkins Installation and Configuration |
| 11 | Jenkins Continuous Integration Pipeline |
| 12 | Automated Testing in Jenkins |
| 13 | Continuous Deployment |
| 14 | End-to-End Testing and Documentation |
| 15 | Final Deployment, Demonstration and Presentation |
## 5. DevOps Workflow

The Carbon Footprint Calculator will follow a Continuous Integration and Continuous Deployment (CI/CD) workflow.

### Workflow

Developer
↓
Code Development
↓
Git
↓
GitHub Repository
↓
Jenkins
↓
Checkout Source Code
↓
Build
↓
Automated Testing
↓
Deployment
↓
Deployed Carbon Footprint Calculator

### Workflow Description

1. The developer creates or modifies the Carbon Footprint Calculator application.
2. The changes are committed using Git.
3. The updated code is pushed to the GitHub repository.
4. Jenkins retrieves the latest source code from GitHub.
5. Jenkins builds the application.
6. Automated tests are executed.
7. If the tests pass, Jenkins deploys the application.
8. The deployed application is verified to ensure that it is working correctly.

This workflow reduces manual deployment effort and helps ensure that application changes are built, tested and deployed consistently.
## 6. Definition of Done

A task will be considered complete when:

- The required functionality has been implemented.
- The acceptance criteria have been satisfied.
- The functionality has been tested.
- Identified bugs have been fixed.
- The code has been committed to GitHub.
- The application continues to work correctly after integration.
- Relevant documentation has been updated.

### Definition of Done for DevOps Tasks

A DevOps task will be considered complete when:

- Jenkins pipeline executes successfully.
- Application build completes successfully.
- Automated tests pass.
- Deployment completes successfully.
- The deployed application can be accessed and verified.