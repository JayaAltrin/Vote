# Use a compatible Maven image for Apple Silicon
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and any other necessary files
COPY pom.xml .
COPY src ./src

# Build the application and skip tests with debug info
RUN mvn clean package -DskipTests -X

# Use the official OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory for the running container
WORKDIR /app

# Copy the jar file from the build stage to the running stage
COPY --from=build /app/target/votebackend2-0.0.1-SNAPSHOT.jar .

# Expose the application port (change if necessary)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "votebackend2-0.0.1-SNAPSHOT.jar"]
