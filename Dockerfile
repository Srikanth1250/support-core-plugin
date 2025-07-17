# Stage 1 - Build
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy Maven files first for better caching
COPY pom.xml .
COPY src ./src

# Use host Maven repository with a volume mount during docker run/build
RUN mvn dependency:go-offline

# Build the Jenkins plugin
RUN mvn clean package

# Stage 2 - Runtime
FROM jenkins/jenkins:lts-jdk17

COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/
