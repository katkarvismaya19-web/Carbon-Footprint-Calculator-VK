# ============================================================
# Carbon Footprint Calculator - Docker Deployment
# ============================================================

FROM tomcat:11.0-jdk21-temurin

LABEL maintainer="Vismaya Katkar"
LABEL project="Carbon Footprint Calculator"

# Remove default Tomcat application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Deploy Carbon Footprint Calculator
COPY build/carbon-footprint-calculator.war \
     /usr/local/tomcat/webapps/carbon-footprint-calculator.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
