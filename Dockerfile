# Step 1: Build stage using Maven
FROM maven:3.9.6-eclipse-temurin-11 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project (skipping tests if needed)
RUN mvn clean package -DskipTests

# Step 2: Runtime stage using JRE
FROM eclipse-temurin:11-jre

# Set working directory
WORKDIR /app

# Copy built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port (change as needed)
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
