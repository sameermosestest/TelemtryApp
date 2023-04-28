# define base docker image
FROM openjdk:8-jdk
RUN addgroup --system spring && adduser --system spring -ingroup spring
USER spring:spring
ARG JAR_FILE=fullstack-backend-0.0.1-SNAPSHOT.jar
COPY opentelemetry-javaagent.jar /opentelemetry-javaagent.jar
COPY ${JAR_FILE} backendapp.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:opentelemetry-javaagent.jar \
-Dotel.traces.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.exporter.otlp.traces.endpoint=http://0.0.0.0:4317 \
-Dotel.exporter.otlp.logs.endpoint=http://0.0.0.0:3100 \
-Dotel.exporter.otlp.insecure=true\
-Dotel.exporter.otlp.traces.insecure=true \
-Dotel.exporter.otlp.metrics.insecure=true \
-Dotel.exporter.otlp.logs.insecure=true \
-Dotel.exporter.otlp.span.insecure=true \
-Dotel.exporter.otlp.metric.insecure=true \
-Dotel.metrics.exporter=prometheus \
-Dotel.exporter.prometheus.port=9464 \
-Dotel.exporter.otlp.metrics.host=0.0.0.0 \
-Dotel.resource.attributes=service.name=user-api"
ENTRYPOINT ["java","-jar","/backendapp.jar"]