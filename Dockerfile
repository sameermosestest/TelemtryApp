# define base docker image
FROM openjdk:8-jdk
RUN addgroup --system spring && adduser --system spring -ingroup spring
USER spring:spring
ARG JAR_FILE=fullstack-backend-0.0.1-SNAPSHOT.jar
COPY opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
COPY ${JAR_FILE} backendapp.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:opentelemetry-javaagent.jar \
-Dotel.traces.exporter=otlp \
-Dotel.metrics.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.exporter.otlp.metrics.endpoint=http://20.85.110.32:9090 \
-Dotel.exporter.otlp.endpoint=http://20.12.97.43:4317 \
-Dotel.exporter.otlp.traces.endpoint=http://20.12.97.43:4317 \
-Dotel.exporter.otlp.logs.endpoint=http://20.72.88.200:3100 \
-Dotel.exporter.otlp.insecure=true\
-Dotel.exporter.otlp.traces.insecure=true \
-Dotel.exporter.otlp.metrics.insecure=true \
-Dotel.exporter.otlp.logs.insecure=true \
-Dotel.exporter.otlp.span.insecure=true \
-Dotel.exporter.otlp.metric.insecure=true \
-Dotel.resource.attributes=service.name=user-api"
ENTRYPOINT ["java","-jar","/backendapp.jar"]