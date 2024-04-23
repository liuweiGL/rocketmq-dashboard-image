FROM openjdk:17-jdk
LABEL maintainer="liuweiGL <wei2460@qq.com>"

ADD rocketmq-dashboard.jar rocketmq-dashboard.jar

USER 1001

EXPOSE 8080

ENV USER_HOME=/
ENV JAVA_OPTS=""

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Duser.home=$USER_HOME -jar /rocketmq-dashboard.jar" ]
