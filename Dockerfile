FROM amazoncorretto:17.0.11-al2023-headless

ADD rocketmq-dashboard.jar rocketmq-dashboard.jar

RUN ls -lh

USER 1001

EXPOSE 8080

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /rocketmq-dashboard.jar" ]
