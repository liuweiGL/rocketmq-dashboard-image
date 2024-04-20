FROM amazoncorretto:8u412-alpine3.19-jre

USER 1001

ADD rocketmq-dashboard.jar

RUN ls -l
RUN touch /rocketmq-dashboard.jar

EXPOSE 8080

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /rocketmq-dashboard.jar" ]
