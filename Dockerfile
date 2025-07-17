# Use Maven with Java 17
FROM maven:3.9.6-eclipse-temurin-17

# Set working directory
WORKDIR /splunk-plugin

# Copy source code into the container
COPY . .

# Build and test the plugin
CMD ["mvn", "test"]
