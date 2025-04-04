# Use OpenJDK 17 base image
FROM maven:3.8.5-openjdk-17 AS build1

# Copy project files
COPY . .

# Build the project
RUN mvn clean package -DskipTests

# Use a smaller runtime image for the final container
FROM eclipse-openjdk:17-jdk-slim

WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /target/backendproj-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT [ "java","-jar" "backendproj.jar"]