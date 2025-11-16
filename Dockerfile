# Build stage
FROM openjdk:11-slim AS base

WORKDIR /app

COPY . .

RUN chmod +x gradlew
RUN ./gradlew build

# Run stage
FROM tomcat:9

WORKDIR /usr/local/tomcat/webapps

COPY --from=base /app/build/libs/myapp.war ./ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

