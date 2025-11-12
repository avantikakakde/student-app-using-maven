FROM tomcat:jdk11
COPY target/*.war webapps/
EXPOSE 8080
