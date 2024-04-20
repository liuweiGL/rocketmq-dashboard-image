FROM amazoncorretto:8u412-alpine3.19-jre

RUN apk update && \
    apk add git

ARG user=rocketmq
ARG group=rocketmq
ARG uid=1001
ARG gid=1001

RUN groupadd -g ${gid} ${group} && \
   useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user}

ARG MAVEN_VERSION=3.9.6
ARG MAVEN_DOWNLOAD_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

ARG TMP_DIR=/opt/tmp

RUN mkdir -p $TMP_DIR/maven && \
    wget -O $TMP_DIR/apache-maven.tar.gz ${MAVEN_DOWNLOAD_URL} && \
    tar -xzf $TMP_DIR/apache-maven.tar.gz -C $TMP_DIR/maven --strip-components=1 && \
    ln -s $TMP_DIR/maven/bin/mvn /usr/bin/mvn

RUN sed -i '159i \
    <mirror> \
    <id>aliyunmaven</id> \
    <mirrorOf>central</mirrorOf> \
    <name>阿里云公共仓库</name> \
    <url>https://maven.aliyun.com/repository/public</url> \
    </mirror> \
' $TMP_DIR/maven/conf/settings.xml



RUN git clone https://github.com/apache/rocketmq-dashboard.git $TMP_DIR/rocketmq-dashboard && \
    cd $TMP_DIR/rocketmq-dashboard && \
    mvn -q -DskipTests clean package && \
    ls -l target;

ENV ROCKETMQ_DASHBOARD_HOME  /home/rocketmq/rocketmq-dashboard
WORKDIR ${ROCKETMQ_DASHBOARD_HOME}

RUN mv $TMP_DIR/rocketmq-dashboard/target/*.jar .

RUN rm -rf ~/.m2/repository/* && \
    rm -rf $TMP_DIR

RUN chown -R ${uid}:${gid} ${ROCKETMQ_DASHBOARD_HOME}
EXPOSE 8080

ENV JAVA_OPTS=""
ENTRYPOINT ["java", "$JAVA_OPTS", "-jar", "*.jar"];