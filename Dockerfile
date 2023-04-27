# define base docker image
FROM openjdk:8-jdk
RUN addgroup --system spring && adduser --system spring -ingroup spring
USER spring:spring
ARG JAR_FILE=fullstack-backend-0.0.1-SNAPSHOT.jar
COPY opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
COPY ${JAR_FILE} backendapp.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:opentelemetry-javaagent.jar"
ENTRYPOINT ["java","-jar","/backendapp.jar"]
