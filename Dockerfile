ARG VER=0.0.1
  
FROM smartentry/alpine:3.13-0.4.4 AS builder
ARG VER
ARG VERSION=${VER}
RUN apk update && \
        apk add openjdk8 maven
COPY fridge-src /opt/fridge-src
RUN cd /opt/fridge-src && \
        mvn clean && \
        mvn package -Dmaven.test.skip=true

FROM smartentry/alpine:3.13-0.4.4
MAINTAINER Zhaofeng Yang <yangzhaofengsteven@gmail.com>
ARG VER
ENV VERSION=${VER}
COPY .docker $ASSETS_DIR
RUN smartentry.sh build
COPY --from=builder /opt/fridge-src/target/twitkit-fridge-${VERSION}.jar /srv/twitkit-fridge
WORKDIR /srv/twitkit-fridge
