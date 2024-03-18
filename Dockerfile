FROM ubuntu:latest AS build
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get install -y maven
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/WebMvcApp07ApplicationTests.jar /app/WebMvcApp07ApplicationTests.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "WebMvcApp07ApplicationTests.jar"]