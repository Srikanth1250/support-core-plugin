# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy source code into container
COPY . .

# Build the plugin and skip tests (optional: remove `-DskipTests` if you want tests to run)
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight image with just the plugin
FROM eclipse-temurin:17-jdk

WORKDIR /plugin

# Copy the HPI file from the builder stage
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# Display file info by default when container runs
CMD ["ls", "-lh", "."]
