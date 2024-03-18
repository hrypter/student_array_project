FROM ubuntu:latest AS build
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get install -y maven
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/src/main/test/java/in/suman/WebMvcApp07ApplicationTests.java /app/WebMvcApp07ApplicationTests.java
EXPOSE 8080
ENTRYPOINT ["javac", "WebMvcApp07ApplicationTests.java"]
