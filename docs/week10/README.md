# Week 10 – Jenkins Continuous Selenium Testing

## Objective

The objective of Week 10 was to integrate Selenium end-to-end testing into the Jenkins pipeline.

## Work Completed

* Added Selenium execution to Jenkins.
* Configured Maven-based Selenium test execution.
* Connected Selenium testing with the deployed Tomcat application.
* Configured the application URL as a test parameter.
* Automated Chrome browser testing.
* Archived Selenium test reports.
* Verified the complete Selenium test suite through Jenkins.

## Jenkins Test Result

The integrated Jenkins pipeline successfully executed:

* 5 Selenium tests
* 5 passed
* 0 failures
* 0 errors

## Outcome

Selenium testing became part of the automated CI/CD verification process, allowing browser-level application functionality to be tested during pipeline execution.

## Main Files

`Jenkinsfile`

`tests/selenium/pom.xml`

`tests/selenium/src/test/java/selenium/CarbonFootprintSeleniumTest.java`
