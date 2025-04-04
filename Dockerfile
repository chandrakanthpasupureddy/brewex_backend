# Stage 1: Build
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src src

# Build the project (with retry for network issues)
RUN mvn clean package -DskipTests || \
    (sleep 30 && mvn clean package -DskipTests)

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=build /app/target/backendproj-0.0.1-SNAPSHOT.jar app.jar

# Security settings
RUN addgroup -S spring && adduser -S spring -G spring \
    && chown spring:spring app.jar
USER spring

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]