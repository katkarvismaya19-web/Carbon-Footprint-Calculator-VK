# \# Week 12 – Jenkins and Docker Continuous Deployment

# 

# \## Objective

# 

# The objective of Week 12 was to integrate Docker image creation, container deployment and health verification into Jenkins.

# 

# \## Work Completed

# 

# \* Added Docker image building to Jenkins.

# \* Generated a build-specific Docker image tag.

# \* Started the Docker application container through Jenkins.

# \* Configured the CI test container on host port 8083.

# \* Added Docker health verification.

# \* Verified HTTP accessibility of the Dockerized application.

# \* Added Docker container cleanup after pipeline execution.

# 

# \## Docker Image

# 

# The pipeline creates images using the project name:

# 

# `carbon-footprint-calculator`

# 

# with build-specific tags such as:

# 

# `carbon-footprint-calculator:1.<BUILD\_NUMBER>`

# 

# \## Jenkins Result

# 

# Docker Build: PASSED

# 

# Docker Deployment: PASSED

# 

# Docker Health Check: PASSED

# 

# \## Outcome

# 

# Docker build, deployment and HTTP health verification were successfully integrated into the Jenkins CI/CD pipeline.



