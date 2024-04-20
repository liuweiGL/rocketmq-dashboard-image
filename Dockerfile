FROM amazoncorretto:8u412-alpine3.19-jre

ADD rocketmq-dashboard.jar rocketmq-dashboard.jar

RUN touch /rocketmq-dashboard.jar

USER 1001

EXPOSE 8080

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /rocketmq-dashboard.jar" ]
