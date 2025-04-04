# Stage 1: Build
FROM openjdk:17-jdk-alpine AS build
RUN apk add --no-cache maven
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine  # Use JRE (smaller than JDK)
WORKDIR /app
COPY --from=build /app/target/backendproj-0.0.1-SNAPSHOT.jar app.jar  # Fixed line
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]