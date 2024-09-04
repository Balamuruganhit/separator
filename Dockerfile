# OpenJdk IMAGE
FROM openjdk:8-jdk-alpine

MAINTAINER Panguns Tech Team

# Install necessary packages and desirable debug tools
RUN apk update && \
    apk upgrade && \
    apk add git && \
    apk add bash && \
    apk add subversion && \
    apk add mysql-client

RUN apk add --update nodejs nodejs-npm
COPY config.env entrypoint.sh /root/

# Expose service ports
EXPOSE 8443
EXPOSE 8080
WORKDIR /root/
ENTRYPOINT ./entrypoint.sh  && sleep 2  && tail -f /ofbiz/runtime/logs/ofbiz.log && bash
