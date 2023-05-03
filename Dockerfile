# define base docker image
FROM openjdk:8-jdk
RUN addgroup --system spring && adduser --system spring -ingroup spring
USER spring:spring
ARG JAR_FILE=fullstack-backend-0.0.1-SNAPSHOT.jar
COPY aws-opentelemetry-agent.jar /aws-opentelemetry-agent.jar
COPY ${JAR_FILE} backendapp.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:aws-opentelemetry-agent.jar \
-Dotel.traces.exporter=otlp \
-Dotel.metrics.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://10.244.0.179:5555 \
-Dotel.resource.attributes=service.name=user-api,service.version=1.0"
ENTRYPOINT ["java","-jar","/backendapp.jar"]
