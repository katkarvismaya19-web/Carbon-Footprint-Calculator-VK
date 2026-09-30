\# Jenkins Deployment for a Carbon Footprint Calculator



\## 📌 Project Overview



The \*\*Carbon Footprint Calculator\*\* is a Java-based web application that calculates carbon emissions based on user activities such as travel and electricity consumption.



This project focuses on implementing a complete \*\*DevOps lifecycle\*\* for the application, including source-code management, automated build and testing, continuous integration, continuous deployment, containerization, configuration verification, health monitoring, and rollback.



The project was developed as a \*\*15-week DevOps implementation\*\* using Jenkins, GitHub, Apache Ant, JUnit, JaCoCo, Selenium, Docker, Docker Compose, Ansible, and Apache Tomcat.



\---



\## 🎯 Objectives



\* Automate the software build and testing process.

\* Implement a Jenkins-based CI/CD pipeline.

\* Perform automated unit and end-to-end testing.

\* Measure code coverage using JaCoCo.

\* Package the application as a WAR file.

\* Deploy the application on Apache Tomcat.

\* Containerize the application using Docker.

\* Implement Docker-based continuous deployment.

\* Use Ansible for environment verification and configuration checks.

\* Implement deployment backup and rollback mechanisms.

\* Perform application health checks.

\* Verify pipeline reliability and repeatability.



\---



\## 🛠️ Technology Stack



| Category                   | Technology         |

| -------------------------- | ------------------ |

| Programming Language       | Java 21            |

| Build Tool                 | Apache Ant         |

| Version Control            | Git                |

| Repository                 | GitHub             |

| CI/CD                      | Jenkins            |

| Unit Testing               | JUnit 5            |

| Code Coverage              | JaCoCo             |

| End-to-End Testing         | Selenium WebDriver |

| Browser                    | Google Chrome      |

| Selenium Build Tool        | Maven              |

| Application Server         | Apache Tomcat 11   |

| Containerization           | Docker             |

| Container Orchestration    | Docker Compose     |

| Configuration Verification | Ansible            |

| Linux Environment          | WSL / Ubuntu       |

| Database                   | MariaDB            |



\---



\## 🏗️ DevOps Architecture



```text

&#x20;                   ┌─────────────────┐

&#x20;                   │     Developer   │

&#x20;                   └────────┬────────┘

&#x20;                            │

&#x20;                            ▼

&#x20;                   ┌─────────────────┐

&#x20;                   │     GitHub      │

&#x20;                   │   Source Code   │

&#x20;                   └────────┬────────┘

&#x20;                            │

&#x20;                            ▼

&#x20;                   ┌─────────────────┐

&#x20;                   │     Jenkins     │

&#x20;                   │    CI / CD      │

&#x20;                   └────────┬────────┘

&#x20;                            │

&#x20;            ┌───────────────┼────────────────┐

&#x20;            ▼               ▼                ▼

&#x20;      ┌──────────┐    ┌──────────┐    ┌────────────┐

&#x20;      │   Ant    │    │  JUnit   │    │   JaCoCo   │

&#x20;      │   Build  │    │  Testing │    │  Coverage  │

&#x20;      └────┬─────┘    └────┬─────┘    └────────────┘

&#x20;           │               │

&#x20;           └───────┬───────┘

&#x20;                   ▼

&#x20;            ┌─────────────┐

&#x20;            │     WAR     │

&#x20;            │   Package   │

&#x20;            └──────┬──────┘

&#x20;                   │

&#x20;            ┌──────┴─────────┐

&#x20;            ▼                ▼

&#x20;     ┌─────────────┐   ┌─────────────┐

&#x20;     │   Tomcat    │   │    Docker   │

&#x20;     │  Deployment │   │  Container  │

&#x20;     └──────┬──────┘   └──────┬──────┘

&#x20;            │                 │

&#x20;            ▼                 ▼

&#x20;     ┌─────────────┐   ┌─────────────┐

&#x20;     │  Selenium   │   │Docker Health│

&#x20;     │ E2E Testing │   │    Check    │

&#x20;     └─────────────┘   └─────────────┘

&#x20;                   │

&#x20;                   ▼

&#x20;            ┌─────────────┐

&#x20;            │   Ansible   │

&#x20;            │ Verification│

&#x20;            └─────────────┘

&#x20;                   │

&#x20;                   ▼

&#x20;            ┌─────────────┐

&#x20;            │ Health Check│

&#x20;            │ + Rollback  │

&#x20;            └─────────────┘

```



\---



\## 🔄 CI/CD Pipeline



The Jenkins pipeline automates the complete application lifecycle:



```text

Checkout

&#x20;  ↓

Build

&#x20;  ↓

Unit Tests

&#x20;  ↓

JaCoCo Coverage

&#x20;  ↓

Create WAR

&#x20;  ↓

Archive WAR

&#x20;  ↓

Backup Previous Deployment

&#x20;  ↓

Deploy to Tomcat

&#x20;  ↓

Deployment Health Check

&#x20;  ↓

Selenium E2E Tests

&#x20;  ↓

Docker Build

&#x20;  ↓

Docker Deployment

&#x20;  ↓

Docker Health Check

&#x20;  ↓

Ansible Verification

&#x20;  ↓

Idempotency Check

&#x20;  ↓

Final Health Check

&#x20;  ↓

Final Integrated Verification

```



\---



\## 🧪 Testing



\### Unit Testing



JUnit 5 is used to test the application's Java components.



Latest successful pipeline result:



```text

Tests run: 5

Failures: 0

Errors: 0

Skipped: 0

```



\### Code Coverage



JaCoCo is integrated into the Ant build process to generate:



\* HTML coverage report

\* XML coverage report

\* Execution data



\### Selenium End-to-End Testing



Selenium WebDriver is used to verify the deployed web application.



The automated test suite verifies:



1\. Login and dashboard access

2\. Build/version information

3\. Activity selection

4\. Carbon emission calculation

5\. Activity type options



Latest result:



```text

Tests run: 5

Failures: 0

Errors: 0

Skipped: 0



BUILD SUCCESS

```



\---



\## 🐳 Docker



The application is containerized using a Docker image based on:



```text

Tomcat 11

JDK 21

```



The Dockerfile:



\* Uses a Tomcat 11 JDK 21 base image.

\* Copies the generated WAR file into Tomcat.

\* Exposes port `8080`.

\* Starts the Tomcat server.



Docker Compose is also provided for simplified application deployment.



\### Docker Ports



| Environment            | Port |

| ---------------------- | ---: |

| Tomcat                 | 8081 |

| Docker Compose         | 8082 |

| Jenkins Docker CI Test | 8083 |



\---



\## ⚙️ Ansible



Ansible is used for environment and deployment verification.



The playbook verifies:



\* Project directory

\* Docker installation

\* Java installation

\* Tomcat directory

\* Application port

\* Documentation directory



The playbook is designed as a \*\*check-only verification workflow\*\*, with tasks configured to avoid unnecessary changes.



Successful result:



```text

ok=8

changed=0

unreachable=0

failed=0

skipped=0

```



Repeated execution produced the same verification result.



\---



\## 🔙 Backup and Rollback



The Jenkins pipeline includes a deployment backup and rollback mechanism.



Before deployment:



```text

Current WAR

&#x20;   ↓

Backup

&#x20;   ↓

New WAR Deployment

&#x20;   ↓

Health Check

```



If the new deployment fails its deployment health check:



```text

Deployment Failure

&#x20;       ↓

Remove Failed Deployment

&#x20;       ↓

Restore Previous WAR

&#x20;       ↓

Verify Application

```



This helps prevent an unsuccessful deployment from permanently replacing the previously working application version.



\---



\## 📅 15-Week DevOps Implementation



| Week    | Work Completed                                   |

| ------- | ------------------------------------------------ |

| Week 1  | Problem definition and project scope             |

| Week 2  | Agile planning and DevOps workflow               |

| Week 3  | Requirements, architecture and environment setup |

| Week 4  | Java development, Ant build and JUnit            |

| Week 5  | Jenkins CI setup                                 |

| Week 6  | GitHub integration and automated builds          |

| Week 7  | JaCoCo coverage and Tomcat deployment            |

| Week 8  | Deployment verification and quality checks       |

| Week 9  | Selenium end-to-end testing                      |

| Week 10 | Jenkins Selenium automation                      |

| Week 11 | Docker containerization                          |

| Week 12 | Jenkins + Docker continuous deployment           |

| Week 13 | Ansible configuration verification               |

| Week 14 | Backup, rollback, health and idempotency checks  |

| Week 15 | Final integrated release and verification        |



Detailed weekly documentation is available under:



```text

docs/week1

docs/week2

...

docs/week15

```



\---



\## 📊 Final Pipeline Verification



The final Jenkins pipeline successfully verified:



| Component                     | Status     |

| ----------------------------- | ---------- |

| GitHub Checkout               | ✅ PASSED   |

| Ant Build                     | ✅ PASSED   |

| JUnit Tests                   | ✅ PASSED   |

| JaCoCo Coverage               | ✅ PASSED   |

| WAR Packaging                 | ✅ PASSED   |

| Tomcat Deployment             | ✅ PASSED   |

| Selenium E2E Tests            | ✅ PASSED   |

| Docker Build                  | ✅ PASSED   |

| Docker Deployment             | ✅ PASSED   |

| Docker Health Check           | ✅ PASSED   |

| Ansible Verification          | ✅ PASSED   |

| Idempotency Check             | ✅ PASSED   |

| Rollback Mechanism            | ✅ VERIFIED |

| Final Health Check            | ✅ PASSED   |

| Final Integrated Verification | ✅ PASSED   |



\### Final Jenkins Status



```text

DEVOPS PROJECT COMPLETED SUCCESSFULLY



W10 Selenium : PASSED

W11 Docker : COMPLETED

W12 Docker CI/CD : PASSED

W13 Ansible : PASSED

W14 Rollback : VERIFIED

W15 Final Release : PASSED



Finished: SUCCESS

```



\---



\## 📁 Project Structure



```text

Carbon-Footprint-Calculator-VK/

│

├── ansible/

│   ├── inventory.ini

│   └── site.yml

│

├── docs/

│   ├── week1/

│   ├── week2/

│   ├── week3/

│   ├── week4/

│   ├── week5/

│   ├── week6/

│   ├── week7/

│   ├── week8/

│   ├── week9/

│   ├── week10/

│   ├── week11/

│   ├── week12/

│   ├── week13/

│   ├── week14/

│   ├── week15/

│   └── week9-15/

│

├── lib/

│

├── src/

│   ├── main/

│   └── test/

│

├── tests/

│   └── selenium/

│       ├── pom.xml

│       ├── README.md

│       ├── TEST\_PLAN.md

│       └── src/

│

├── ansible/

├── Dockerfile

├── docker-compose.yml

├── Jenkinsfile

├── build.xml

└── README.md

```



\---



\## 🚀 How to Build Locally



\### 1. Clone the repository



```bash

git clone https://github.com/katkarvismaya19-web/Carbon-Footprint-Calculator-VK.git

cd Carbon-Footprint-Calculator-VK

```



\### 2. Build using Ant



```bash

ant clean

ant coverage

ant war

```



The generated WAR file is:



```text

build/carbon-footprint-calculator.war

```



\### 3. Run Selenium Tests



From the Selenium directory:



```bash

cd tests/selenium

mvn clean test -DbaseUrl=http://localhost:8081/carbon-footprint-calculator/

```



\---



\## 🔐 Configuration



Database configuration supports environment variables/system properties rather than requiring database credentials to be hardcoded into the application.



Supported configuration:



```text

DB\_HOST

DB\_PORT

DB\_NAME

DB\_USER

DB\_PASSWORD

```



Example:



```text

DB\_HOST=localhost

DB\_PORT=3306

DB\_NAME=carbon\_footprint\_db

DB\_USER=root

DB\_PASSWORD=

```



Sensitive credentials should not be committed to the repository.



\---



\## 📚 Documentation



The `docs` directory contains the documentation for all 15 weeks of the project.



Additional documentation includes:



\* Agile planning

\* Requirements and architecture

\* Docker lifecycle

\* Final DevOps workflow

\* Final verification checklist

\* Selenium testing documentation

\* Ansible configuration

\* Deployment and rollback workflow



\---



\## 👩‍💻 Project



\*\*Project:\*\* Jenkins Deployment for a Carbon Footprint Calculator

\*\*Developer:\*\* Vismaya Katkar

\*\*Domain:\*\* DevOps / Software Engineering

\*\*Duration:\*\* 15 Weeks

\*\*Application:\*\* Carbon Footprint Calculator



\---



\## 📌 Conclusion



This project demonstrates an end-to-end DevOps workflow for a Java web application, integrating source control, automated builds, testing, code coverage, CI/CD, application deployment, containerization, configuration verification, health monitoring, and rollback into a single Jenkins pipeline.



The final integrated Jenkins pipeline completed successfully with all planned verification stages passing.



