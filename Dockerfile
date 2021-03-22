FROM maven:3-openjdk-8
WORKDIR /root
COPY fridge-src fridge-src
RUN mvn clean -f fridge-src/pom.xml
RUN mvn package -f fridge-src/pom.xml -Dmaven.test.skip=true

FROM openjdk:8-jre-alpine
ENV JDBC_URL='jdbc:mysql://host.docker.internal:3306/fridge_test?characterEncoding=utf-8&useSSL=true&serverTimezone=Asia/Shanghai' \
    USERNAME='fridge_test' \
    PASSWORD='fridge_test'
WORKDIR /root
COPY --from=0 /root/fridge-src/target/twitkit-fridge-*.jar .
CMD java -jar twitkit-fridge-*.jar \
    --spring.datasource.yui.jdbc-url=${JDBC_URL} \
    --spring.datasource.yui.username=${USERNAME} \
    --spring.datasource.yui.password=${PASSWORD}
EXPOSE 8220