FROM openjdk:17-jdk
LABEL maintainer="liuweiGL <wei2460@qq.com>"

ENV WORK_DIR=/opt/rocketmq-dashboard

WORKDIR $WORK_DIR

COPY conf conf
COPY rocketmq-dashboard.jar rocketmq-dashboard.jar

ENV JAVA_OPTS=""

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS}  -jar rocketmq-dashboard.jar --spring.config.location=${WORK_DIR}/conf/application.yaml" ]
