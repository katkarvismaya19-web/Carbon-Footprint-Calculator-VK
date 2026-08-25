\# Week 3 – Requirements, Architecture \& Technology Setup



\## 1. Objective



The objective of Week 3 is to define the requirements, architecture, database design, technology stack, user roles, and deployment strategy for the Carbon Footprint Calculator MVP.



The system will allow users to record carbon-emitting activities, calculate estimated CO2 emissions, view and update records, search historical records, and monitor their carbon footprint through a dashboard.



\## 2. Functional Requirements



\### FR1 – User Registration and Login

Users should be able to register and securely log in to the application.



\### FR2 – Record Carbon Activities

Users can enter activities such as transportation, electricity consumption, fuel usage, and waste generation.



\### FR3 – Calculate Carbon Footprint

The system calculates estimated CO2 emissions using predefined emission factors.



\### FR4 – View Records

Users can view their previously submitted carbon-footprint records.



\### FR5 – Update Records

Users can modify previously entered activity records.



\### FR6 – Search Records

Users can search records using activity type, date, or record ID.



\### FR7 – Dashboard

The dashboard displays total emissions, emissions by category, recent records, and emission trends.



\### FR8 – Role-Based Workflow



User:

\- Register and login

\- Add carbon records

\- View records

\- Update records

\- Search records

\- View personal dashboard



Administrator:

\- Login

\- View user records

\- Manage emission factors

\- Monitor system data

\- Access admin dashboard



\## 3. Non-Functional Requirements



\- Performance: The application should provide reasonable response time for normal MVP usage.

\- Security: Authentication and role-based authorization should protect restricted features.

\- Reliability: The system should validate user input and handle errors properly.

\- Maintainability: The application should use a modular structure.

\- Scalability: The architecture should support additional users and emission categories.

\- Usability: The interface should be simple and easy to understand.



\## 4. MVP Architecture



The application follows a layered web architecture:



User / Administrator

&#x20;       |

&#x20;       v

Web Browser / Frontend

&#x20;       |

&#x20;       v

Apache Tomcat

&#x20;       |

&#x20;       v

Java Servlet Application

&#x20;       |

&#x20;       +---- Authentication

&#x20;       +---- Carbon Calculation

&#x20;       +---- Record Management

&#x20;       +---- Search

&#x20;       +---- Dashboard

&#x20;       |

&#x20;       v

MySQL Database



\## 5. Technology Stack



| Component | Technology |

|---|---|

| Programming Language | Java |

| Frontend | HTML, CSS, JavaScript, Bootstrap |

| Backend | Java Servlets |

| Database | MySQL |

| Build Tool | Apache Ant |

| Application Server | Apache Tomcat |

| CI/CD | Jenkins |

| Version Control | Git and GitHub |

| Reverse Proxy | Nginx - future option |



\## 6. Database Design



\### Users Table



| Field | Description |

|---|---|

| user\_id | Unique user ID |

| name | User name |

| email | Login email |

| password | Encrypted password |

| role | USER or ADMIN |



\### Carbon Records Table



| Field | Description |

|---|---|

| record\_id | Unique record ID |

| user\_id | Associated user |

| activity\_type | Type of activity |

| activity\_value | Activity amount |

| unit | Measurement unit |

| emission\_factor | CO2 conversion factor |

| carbon\_emission | Calculated emission |

| record\_date | Activity date |



\### Emission Factors Table



| Field | Description |

|---|---|

| factor\_id | Unique factor ID |

| activity\_type | Activity category |

| unit | Measurement unit |

| emission\_factor | CO2 conversion factor |



\## 7. Build Tool Decision



Apache Ant is selected for the MVP because it has already been configured and tested in the project environment and successfully generates a WAR file for Tomcat deployment.



Maven and Gradle can be considered in future versions if dependency management becomes more complex.



\## 8. Server Decision



Apache Tomcat is selected as the MVP application server because the Java web application can be packaged as a WAR file and deployed directly to Tomcat.



Nginx may be introduced later as a reverse proxy for production deployment.



\## 9. CI/CD Workflow



Developer

&#x20;   |

&#x20;   v

Git / GitHub

&#x20;   |

&#x20;   v

Jenkins

&#x20;   |

&#x20;   v

Apache Ant

&#x20;   |

&#x20;   v

WAR File

&#x20;   |

&#x20;   v

Apache Tomcat

&#x20;   |

&#x20;   v

Carbon Footprint Calculator



\## 10. User Workflow



Login

&#x20; |

&#x20; v

User Dashboard

&#x20; |

&#x20; +--> Add Carbon Record

&#x20; +--> View Records

&#x20; +--> Update Record

&#x20; +--> Search Records

&#x20; +--> View Carbon Summary



\## 11. Administrator Workflow



Admin Login

&#x20;   |

&#x20;   v

Admin Dashboard

&#x20;   |

&#x20;   +--> View User Records

&#x20;   +--> Manage Emission Factors

&#x20;   +--> Monitor System Data



\## 12. MVP Scope



The MVP will include:



1\. User authentication

2\. Role-based access

3\. Carbon activity entry

4\. Carbon emission calculation

5\. Create, view, update and search records

6\. User dashboard

7\. Admin dashboard

8\. MySQL database

9\. Ant build

10\. Jenkins and Tomcat deployment



Advanced features such as mobile applications, IoT integration, AI recommendations, and advanced analytics are outside the initial MVP scope.



\## 13. Success Criteria



Week 3 will be considered complete when:



\- Functional requirements are documented.

\- Non-functional requirements are documented.

\- User roles are defined.

\- MVP architecture is documented.

\- Database entities are identified.

\- Technology stack is finalized.

\- Ant build strategy is defined.

\- Tomcat deployment strategy is defined.

\- Jenkins workflow is documented.



\## 14. Week 3 Deliverable



The Week 3 deliverable is the approved requirements, architecture, database design, technology stack, and deployment strategy for the Carbon Footprint Calculator MVP.



Status: Week 3 Requirements and Architecture Defined

