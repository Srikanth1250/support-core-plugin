# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Avoid re-downloading dependencies if only code changes
COPY pom.xml .
RUN mvn dependency:go-offline

# Now copy the rest of the project
COPY . .

# Build the plugin
RUN mvn clean package

# Stage 2: Minimal image with just the .hpi file
FROM eclipse-temurin:17-jdk

WORKDIR /plugin

# Copy only the built .hpi plugin file
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# Optional: list output
CMD ["ls", "-lh", "."]
