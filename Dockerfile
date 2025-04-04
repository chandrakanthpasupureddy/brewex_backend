# Stage 1: Build
FROM openjdk:17-jdk-alpine AS build

# Install Maven
RUN apk add --no-cache maven

WORKDIR /app

# Copy project files
COPY . .

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Run - Use smaller JRE image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built JAR
COPY --from=build /app/target/backendproj-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Run as non-root user (security best practice)
RUN addgroup -S spring && adduser -S spring -G spring \
    && chown spring:spring app.jar
USER spring

CMD ["java", "-jar", "app.jar"]