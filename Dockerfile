FROM 3.3-alpine as build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM jre8-alpine
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/