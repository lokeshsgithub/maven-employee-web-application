FROM maven:3.3-alpine as build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:jre8-alpine
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
