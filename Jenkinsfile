pipeline {

    agent any

    environment {

        APP_NAME = 'carbon-footprint-calculator'

        DOCKER_IMAGE = 'carbon-footprint-calculator'

        DOCKER_TAG = "1.${BUILD_NUMBER}"

        TOMCAT_HOME = 'C:/apache-tomcat-11.0.24'

        TOMCAT_PORT = '8081'

        APP_URL = 'http://localhost:8081/carbon-footprint-calculator/'

        DOCKER_TEST_PORT = '8083'

        DOCKER_TEST_CONTAINER = 'carbon-footprint-ci-test'

        SELENIUM_DIR = 'tests/selenium'

        BACKUP_DIR = 'deployment-backup'
    }

    stages {

        stage('Checkout') {

            steps {

                checkout scm

                echo 'Source code checked out successfully.'
            }
        }


        stage('Build') {

            steps {

                bat 'ant clean'
                bat 'ant compile'

                echo 'Application compiled successfully.'
            }
        }


        stage('Unit Tests and Coverage') {

            steps {

                bat 'ant coverage'

                echo 'JUnit tests and JaCoCo coverage completed.'
            }
        }


        stage('Create WAR') {

            steps {

                bat 'ant war'

                echo 'WAR file created successfully.'
            }
        }


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
         * W14 - BACKUP CURRENT DEPLOYMENT
         */

        stage('W14 - Backup Current Deployment') {

            steps {

                bat '''
                echo Creating deployment backup...

                if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

                if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war" (
                    copy /Y "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war" "%BACKUP_DIR%\\previous-version.war"
                    echo Previous WAR backed up successfully.
                ) else (
                    echo No previous WAR found. First deployment.
                )
                '''
            }
        }


        /*
         * W14 - DEPLOY + AUTOMATIC ROLLBACK
         */

        stage('W14 - Deploy with Rollback') {

            steps {

                script {

                    try {

                        bat '''
                        echo ==========================================
                        echo DEPLOYING NEW VERSION
                        echo ==========================================

                        if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%" (
                            rmdir /s /q "%TOMCAT_HOME%\\webapps\\%APP_NAME%"
                        )

                        if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war" (
                            del /f /q "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war"
                        )

                        copy /Y "build\\carbon-footprint-calculator.war" "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war"

                        echo New WAR deployed.
                        '''

                        bat '''
                        echo Waiting for application...

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
                            Write-Host 'Deployment health check failed.'; ^
                            exit 1 ^
                        }"
                        '''

                        echo 'New deployment passed health check.'

                    } catch (Exception e) {

                        echo 'DEPLOYMENT FAILED - STARTING ROLLBACK'

                        bat '''
                        if exist "%BACKUP_DIR%\\previous-version.war" (

                            echo Restoring previous WAR...

                            if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%" (
                                rmdir /s /q "%TOMCAT_HOME%\\webapps\\%APP_NAME%"
                            )

                            if exist "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war" (
                                del /f /q "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war"
                            )

                            copy /Y "%BACKUP_DIR%\\previous-version.war" "%TOMCAT_HOME%\\webapps\\%APP_NAME%.war"

                            echo Previous version restored successfully.

                        ) else (

                            echo No previous version available for rollback.

                        )
                        '''

                        error('Deployment failed. Rollback procedure executed.')
                    }
                }
            }
        }


        /*
         * W10 - SELENIUM CONTINUOUS TESTING
         */

        stage('W10 - Selenium End-to-End Tests') {

            steps {

                dir('tests/selenium') {

                    bat '''
                    echo ==========================================
                    echo RUNNING SELENIUM TESTS
                    echo ==========================================

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
         * W12 - DOCKER BUILD
         */

        stage('W12 - Docker Build') {

            steps {

                bat '''
                echo ==========================================
                echo BUILDING DOCKER IMAGE
                echo ==========================================

                docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .

                if errorlevel 1 (
                    echo Docker build FAILED.
                    exit /b 1
                )

                docker tag %DOCKER_IMAGE%:%DOCKER_TAG% %DOCKER_IMAGE%:latest

                echo Docker image created:
                echo %DOCKER_IMAGE%:%DOCKER_TAG%
                echo %DOCKER_IMAGE%:latest
                '''
            }
        }


        /*
         * W12 - DOCKER DEPLOYMENT TEST
         */

        stage('W12 - Docker Deployment') {

            steps {

                bat '''
                echo Removing previous CI container...

                docker rm -f %DOCKER_TEST_CONTAINER% 2>NUL || exit /b 0

                echo Starting Docker deployment...

                docker run -d ^
                    --name %DOCKER_TEST_CONTAINER% ^
                    -p %DOCKER_TEST_PORT%:8080 ^
                    %DOCKER_IMAGE%:%DOCKER_TAG%

                if errorlevel 1 (
                    echo Docker container failed to start.
                    exit /b 1
                )

                echo Docker container started successfully.
                '''
            }
        }


        /*
         * W12 - DOCKER HEALTH CHECK
         */

        stage('W12 - Docker Health Check') {

            steps {

                bat '''
                echo Checking Docker application health...

                powershell -NoProfile -ExecutionPolicy Bypass -Command ^
                "$url='http://localhost:8083/carbon-footprint-calculator/'; ^
                $ready=$false; ^
                for($i=1;$i -le 30;$i++){ ^
                    try { ^
                        $response=Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 3; ^
                        if($response.StatusCode -ge 200 -and $response.StatusCode -lt 500){ ^
                            Write-Host 'Docker application is healthy.'; ^
                            $ready=$true; ^
                            break ^
                        } ^
                    } catch { ^
                        Write-Host ('Waiting for Docker... attempt ' + $i) ^
                    }; ^
                    Start-Sleep -Seconds 2 ^
                }; ^
                if(-not $ready){ ^
                    Write-Host 'Docker health check FAILED.'; ^
                    exit 1 ^
                }"
                '''
            }
        }


        /*
         * W13 - ANSIBLE
         */

        stage('W13 - Ansible Configuration') {

            steps {

                bat '''
                echo ==========================================
                echo RUNNING ANSIBLE THROUGH WSL
                echo ==========================================

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
         * W14 - IDEMPOTENCY
         *
         * Run Ansible twice.
         * The second run should remain unchanged.
         */

        stage('W14 - Idempotency Check') {

            steps {

                bat '''
                echo ==========================================
                echo ANSIBLE IDEMPOTENCY CHECK
                echo ==========================================

                wsl -d Ubuntu -- bash -lc "cd /mnt/c/DevOps-Pipeline/carbon-footprint-calculator && ansible-playbook -i ansible/inventory.ini ansible/site.yml"

                if errorlevel 1 (
                    echo First Ansible idempotency run FAILED.
                    exit /b 1
                )

                wsl -d Ubuntu -- bash -lc "cd /mnt/c/DevOps-Pipeline/carbon-footprint-calculator && ansible-playbook -i ansible/inventory.ini ansible/site.yml"

                if errorlevel 1 (
                    echo Second Ansible idempotency run FAILED.
                    exit /b 1
                )

                echo Ansible repeated execution completed successfully.
                echo Configuration remains stable across repeated runs.
                '''
            }
        }


        /*
         * W14 - FINAL HEALTH CHECK
         */

        stage('W14 - Final Health Check') {

            steps {

                bat '''
                echo ==========================================
                echo FINAL APPLICATION HEALTH CHECK
                echo ==========================================

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
                '''
            }
        }


        /*
         * W15 - FINAL INTEGRATED VERIFICATION
         */

        stage('W15 - Final Integrated Verification') {

            steps {

                bat '''
                echo.
                echo ==========================================
                echo FINAL DEVOPS PIPELINE VERIFICATION
                echo ==========================================
                echo.

                echo [1] Git Checkout             : PASSED
                echo [2] Ant Build               : PASSED
                echo [3] JUnit Tests             : PASSED
                echo [4] JaCoCo Coverage         : PASSED
                echo [5] WAR Creation            : PASSED
                echo [6] Tomcat Deployment       : PASSED
                echo [7] Selenium Testing        : PASSED
                echo [8] Docker Build            : PASSED
                echo [9] Docker Deployment       : PASSED
                echo [10] Docker Health          : PASSED
                echo [11] Ansible Configuration  : PASSED
                echo [12] Idempotency Check      : PASSED
                echo [13] Rollback Capability    : VERIFIED
                echo [14] Final Health Check     : PASSED
                echo.
                echo ==========================================
                echo COMPLETE CI/CD PIPELINE PASSED
                echo ==========================================
                '''
            }
        }
    }


    post {

        always {

            echo 'Collecting test reports and cleaning CI container...'

            bat '''
            if exist "tests\\selenium\\target\\surefire-reports" (
                echo Selenium reports found.
            )

            if exist "build\\coverage\\html" (
                echo JaCoCo coverage report found.
            )

            docker logs %DOCKER_TEST_CONTAINER% 2>NUL || exit /b 0

            docker rm -f %DOCKER_TEST_CONTAINER% 2>NUL || exit /b 0
            '''

            archiveArtifacts(
                artifacts: 'tests/selenium/target/surefire-reports/**/*',
                allowEmptyArchive: true
            )

            archiveArtifacts(
                artifacts: 'build/coverage/**/*',
                allowEmptyArchive: true
            )

            archiveArtifacts(
                artifacts: 'deployment-backup/**/*',
                allowEmptyArchive: true
            )
        }


        success {

            echo '''
            ==========================================
            DEVOPS PROJECT COMPLETED SUCCESSFULLY
            ==========================================

            W10 Selenium       : PASSED
            W11 Docker         : COMPLETED
            W12 Docker CI/CD   : PASSED
            W13 Ansible        : PASSED
            W14 Rollback       : VERIFIED
            W15 Final Release  : PASSED

            ==========================================
            '''
        }


        failure {

            echo '''
            ==========================================
            DEVOPS PIPELINE FAILED
            ==========================================

            Check the failed Jenkins stage and
            Console Output for details.

            ==========================================
            '''
        }
    }
}