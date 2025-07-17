# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy all project files
COPY . .

# Build the plugin
RUN mvn clean package

# Stage 2: Minimal image with just the .hpi file
FROM eclipse-temurin:17-jdk

WORKDIR /plugin

# Copy only the built plugin
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# Optional: Display structure
CMD ["ls", "-lh", "."]
