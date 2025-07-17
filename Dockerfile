# ----------- Stage 1: Build the Jenkins plugin using Maven -----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Install Git and Zip if needed by plugin build (optional)
RUN apt-get update && apt-get install -y git zip && apt-get clean

# Set working directory for build
WORKDIR /app

# Copy plugin source code
COPY . .

# Build the Jenkins plugin (.hpi file will be in target/)
RUN mvn clean package


# ----------- Stage 2: Runtime image with plugin .hpi only -----------
FROM eclipse-temurin:17-jdk

# Optional: Use /var/jenkins_home/plugins if integrating with Jenkins
WORKDIR /plugin

# Copy the built plugin .hpi file from builder
COPY --from=builder /app/target/*.hpi ./my-jenkins-plugin.hpi

# Default command (shows contents for debug)
CMD ["ls", "-lh", "."]
