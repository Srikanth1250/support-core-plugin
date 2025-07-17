# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Install tools needed for Jenkins plugin builds
RUN apt-get update && apt-get install -y git zip

WORKDIR /app

# Copy everything at once (since go-offline removed)
COPY . .

# Build the plugin
RUN mvn clean package

# Stage 2: Copy only final .hpi file
FROM eclipse-temurin:17-jdk

WORKDIR /plugin

COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

CMD ["ls", "-lh", "."]
