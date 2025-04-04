# Stage 1: Build
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Copy Maven wrapper and POM first (for layer caching)
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src src

# Build with retry logic
RUN ./mvnw clean package -DskipTests || \
    (sleep 10 && ./mvnw clean package -DskipTests)

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Security settings
RUN addgroup -S spring && adduser -S spring -G spring \
    && chown spring:spring app.jar
USER spring

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]