# define base docker image
FROM openjdk:8-jdk
RUN addgroup --system spring && adduser --system spring -ingroup spring
USER spring:spring
COPY opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
ARG JAR_FILE=target/fullstack-backend-0.0.1-SNAPSHOT.jar.jar
COPY ${JAR_FILE} backendapp.jar
ENTRYPOINT ["java","-jar","/backendapp.jar"]
