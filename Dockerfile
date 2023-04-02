FROM tomcat:8.0.15-jre8
COPY target/*.war /usr/local/tomcat/webapps/
