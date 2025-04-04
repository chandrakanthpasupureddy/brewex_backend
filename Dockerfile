# Use OpenJDK 17 base image
FROM openjdk:17-jdk-alpine AS build
 
# Install Maven
RUN apk add --no-cache maven

WORKDIR /app

# Copy project files
COPY . .

# Build the project
RUN mvn clean package -DskipTests

# Use a smaller runtime image for the final container
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080