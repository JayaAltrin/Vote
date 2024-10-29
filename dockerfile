# Use the official Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory for the running container
WORKDIR /app

# Copy the JAR file from the build stage to the running stage
COPY --from=build /app/target/votebackend2-0.0.1-SNAPSHOT.jar .

# Expose the application port (change if necessary)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "votebackend2-0.0.1-SNAPSHOT.jar"]
