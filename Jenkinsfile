pipeline {

    agent any

    environment {

        APP_NAME = 'carbon-footprint-calculator'

        DOCKER_IMAGE = 'carbon-footprint-calculator'

        DOCKER_TAG = "1.${BUILD_NUMBER}"

        TOMCAT_HOME = 'C:/apache-tomcat-11.0.24'

        TOMCAT_PORT = '8081'

        APP_URL = 'http://localhost:8081/carbon-footprint-calculator/'

        SELENIUM_DIR = 'tests/selenium'
    }

    stages {

        /*
         * =========================================================
         * 1. CHECKOUT
         * =========================================================
         */

        stage('Checkout') {

            steps {

                checkout scm

                echo 'Source code checked out successfully.'
            }
        }


        /*
         * =========================================================
         * 2. BUILD
         * =========================================================
         */

        stage('Build') {

            steps {

                bat 'ant clean'

                bat 'ant compile'

                echo 'Application compiled successfully.'
            }
        }


        /*
         * =========================================================
         * 3. UNIT TESTS + JACOCO
         * =========================================================
         */

        stage('Unit Tests and Coverage') {

            steps {

                bat 'ant coverage'

                echo 'JUnit tests and JaCoCo coverage completed.'
            }
        }


        /*
         * =========================================================
         * 4. CREATE WAR
         * =========================================================
         */

        stage('Create WAR') {

            steps {

                bat 'ant war'

                echo 'WAR file created successfully.'
            }
        }


        /*
         * =========================================================
         * 5. ARCHIVE WAR
         * =========================================================
         */

        stage('Archive WAR') {

            steps {

                archiveArtifacts(
                    artifacts: 'build/carbon-footprint-calculator.war',
                    fingerprint: true
                )

                echo 'WAR archived successfully.'
            }
        }


        /*
         * =========================================================
         * 6. DEPLOY TO TOMCAT
         * =========================================================
         */

        stage('Deploy to Tomcat') {

            steps {

                bat '''
                echo Deploying WAR to Tomcat...

                if not exist "%TOMCAT_HOME%\\webapps" (
                    echo ERROR: Tomcat webapps directory not found.
                    exit /b 1
                )

                if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%" (
                    rmdir /s /q "%TOMCAT_HOME%\\webapps\\%APP_NAME%"
                )

                if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war" (
                    del /f /q "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war"
                )

                copy /Y "build\\carbon-footprint-calculator.war" "%TOMCAT_HOME%\\webapps\\carbon-footprint-calculator.war"

                echo WAR copied to Tomcat successfully.
                '''
            }
        }


        /*
         * =========================================================
         * 7. WAIT FOR TOMCAT APPLICATION
         * =========================================================
         */

        stage('Wait for Application') {

            steps {

                bat '''
                echo Waiting for Tomcat application...

                powershell -NoProfile -ExecutionPolicy Bypass -Command ^
                "$url='http://localhost:8081/carbon-footprint-calculator/'; ^
                $ready=$false; ^
                for($i=1;$i -le 30;$i++){ ^
                    try { ^
                        $response=Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 3; ^
                        if($response.StatusCode -ge 200 -and $response.StatusCode -lt 500){ ^
                            Write-Host 'Application is responding.'; ^
                            $ready=$true; ^
                            break ^
                        } ^
                    } catch { ^
                        Write-Host ('Waiting... attempt ' + $i) ^
                    }; ^
                    Start-Sleep -Seconds 2 ^
                }; ^
                if(-not $ready){ ^
                    Write-Host 'Application did not become available.'; ^
                    exit 1 ^
                }"
                '''
            }
        }


        /*
         * =========================================================
         * 8. SELENIUM END-TO-END TESTS
         * =========================================================
         */

        stage('Selenium End-to-End Tests') {

            steps {

                dir('tests/selenium') {

                    bat '''
                    echo Running Selenium end-to-end tests...

                    mvn clean test -DbaseUrl=http://localhost:8081/carbon-footprint-calculator/

                    if errorlevel 1 (
                        echo Selenium tests FAILED.
                        exit /b 1
                    )

                    echo Selenium tests PASSED.
                    '''
                }
            }
        }


        /*
         * =========================================================
         * 9. DOCKER BUILD
         * =========================================================
         */

        stage('Docker Build') {

            steps {

                bat '''
                echo Building Docker image...

                docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .

                if errorlevel 1 (
                    echo Docker build FAILED.
                    exit /b 1
                )

                echo Docker image built successfully.
                '''
            }
        }


        /*
         * =========================================================
         * 10. DOCKER CONTAINER TEST
         * =========================================================
         */

        stage('Docker Container Test') {

            steps {

                bat '''
                echo Starting Docker test container...

                docker rm -f carbon-footprint-ci-test 2>NUL || exit /b 0

                docker run -d ^
                    --name carbon-footprint-ci-test ^
                    -p 8083:8080 ^
                    %DOCKER_IMAGE%:%DOCKER_TAG%

                if errorlevel 1 (
                    echo Docker container FAILED to start.
                    exit /b 1
                )

                echo Docker container started.
                '''
            }
        }


        /*
         * =========================================================
         * 11. DOCKER HEALTH CHECK
         * =========================================================
         */

        stage('Docker Health Check') {

            steps {

                bat '''
                echo Waiting for Docker application...

                powershell -NoProfile -ExecutionPolicy Bypass -Command ^
                "$url='http://localhost:8083/carbon-footprint-calculator/'; ^
                $ready=$false; ^
                for($i=1;$i -le 30;$i++){ ^
                    try { ^
                        $response=Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 3; ^
                        if($response.StatusCode -ge 200 -and $response.StatusCode -lt 500){ ^
                            Write-Host 'Docker application is responding.'; ^
                            $ready=$true; ^
                            break ^
                        } ^
                    } catch { ^
                        Write-Host ('Waiting for Docker... attempt ' + $i) ^
                    }; ^
                    Start-Sleep -Seconds 2 ^
                }; ^
                if(-not $ready){ ^
                    Write-Host 'Docker application health check FAILED.'; ^
                    exit 1 ^
                }"
                '''
            }
        }


        /*
         * =========================================================
         * 12. ANSIBLE CONFIGURATION CHECK
         * =========================================================
         */

        stage('Ansible Configuration Check') {

    steps {

        bat '''
        echo Running Ansible configuration check through WSL...

        wsl -d Ubuntu -- bash -lc "cd /mnt/c/DevOps-Pipeline/carbon-footprint-calculator && ansible-playbook -i ansible/inventory.ini ansible/site.yml"

        if errorlevel 1 (
            echo Ansible configuration FAILED.
            exit /b 1
        )

        echo Ansible configuration completed successfully.
        '''
    }
}


        /*
         * =========================================================
         * 13. FINAL APPLICATION CHECK
         * =========================================================
         */

        stage('Final Health Check') {

            steps {

                bat '''
                echo Performing final Tomcat health check...

                powershell -NoProfile -ExecutionPolicy Bypass -Command ^
                "$url='http://localhost:8081/carbon-footprint-calculator/'; ^
                try { ^
                    $response=Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10; ^
                    Write-Host ('Final HTTP Status: ' + $response.StatusCode); ^
                    if($response.StatusCode -lt 200 -or $response.StatusCode -ge 500){exit 1} ^
                } catch { ^
                    Write-Host 'Final health check FAILED.'; ^
                    exit 1 ^
                }"

                echo Final application health check PASSED.
            }
        }
    }


    /*
     * =============================================================
     * POST ACTIONS
     * =============================================================
     */

    post {

always {

    echo 'Collecting test and Docker information...'

    bat '''
    if exist "tests\\selenium\\target\\surefire-reports" (
        echo Selenium reports found.
    )

    if exist "build\\coverage\\html" (
        echo JaCoCo coverage report found.
    )

    docker logs carbon-footprint-ci-test 2>NUL || exit /b 0

    docker rm -f carbon-footprint-ci-test 2>NUL || exit /b 0
    '''

    archiveArtifacts(
        artifacts: 'tests/selenium/target/surefire-reports/**/*',
        allowEmptyArchive: true
    )

    archiveArtifacts(
        artifacts: 'build/coverage/**/*',
        allowEmptyArchive: true
    )
}
        success {

            echo '''
            ==========================================
            CI/CD PIPELINE COMPLETED SUCCESSFULLY
            ==========================================
            Checkout       : PASSED
            Build          : PASSED
            Unit Tests     : PASSED
            JaCoCo         : PASSED
            WAR            : PASSED
            Tomcat Deploy  : PASSED
            Selenium       : PASSED
            Docker Build   : PASSED
            Docker Health  : PASSED
            Ansible        : PASSED
            Final Check    : PASSED
            ==========================================
            '''
        }

        failure {

            echo '''
            ==========================================
            CI/CD PIPELINE FAILED
            ==========================================
            Check the failed stage in Jenkins Console
            Output for details.
            ==========================================
            '''
        }
    }
}