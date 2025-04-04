# Stage 1: Build
FROM maven:3.8.7-openjdk-21 AS build

WORKDIR /app
COPY pom.xml .
COPY src src

RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app
COPY --from=build /app/target/backendproj-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]