# Dockerfile to build the EdExchange directory server

From tomcat:7
MAINTAINER James Whetstone <jwhetstone@ccctechcenter.org>
LABEL Description="This image is used to build the EdExchange directory server. Although it can be created using normal docker commands, it's intended use is in conjunction with the proxy server image and the database image using docker compose as described in the README.md"

ENV JAVA_HOME /usr

# add the virtual directory from the host
RUN mkdir /opt/edexchange

# the context file will have the resource connection
ADD ./context.xml /usr/local/tomcat/conf/context.xml

# needed to connect the database
ADD ./mariadb-java-client-1.1.7.jar /usr/local/tomcat/lib/mariadb-java-client-1.1.7.jar

EXPOSE 8009
EXPOSE 8080

ADD ./directory-server.xml /usr/local/tomcat/conf/Catalina/localhost/directory-server.xml

CMD /usr/local/tomcat/bin/catalina.sh run
