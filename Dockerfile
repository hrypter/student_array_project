# Build stage
FROM maven:latest AS build
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven && \
    apt-get clean
WORKDIR /app
COPY . .
RUN mvn clean package

# Run stage
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/src/main/java/in/suman/WebMVC-App07-0.0.1-SNAPSHOT.jar WebMvc-AppO7.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "WebMvc-AppO7.jar"]
