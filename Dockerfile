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
COPY --from=build /app/suman/src/main/java/in/suman/WebMVCApp07Application.java WebMvcAppO7Application.java
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "WebMvcAppO7Application.jar"]
