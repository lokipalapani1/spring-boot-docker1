# First stage: build the application with Maven
FROM maven:3.8.3-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /app/src/
RUN mvn package

#second stage: Copy jar file and run
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/api-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
CMD ["java", "-jar", "/app/target/api-0.0.1-SNAPSHOT.jar"]
