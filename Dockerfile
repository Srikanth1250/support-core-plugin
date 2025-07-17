# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Install tools required by Jenkins plugin builds
RUN apt-get update && apt-get install -y git zip

WORKDIR /app

# Copy pom.xml first to leverage Docker cache
COPY pom.xml .

# Pre-fetch dependencies (faster rebuilds)
RUN mvn dependency:go-offline

# Copy rest of the project
COPY . .

# Build the plugin
RUN mvn clean package

# Stage 2: Create a minimal image with just the .hpi
FROM eclipse-temurin:17-jdk

WORKDIR /plugin

# Copy the plugin file
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# List output by default
CMD ["ls", "-lh", "."]
