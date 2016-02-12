# Dockerfile to build the EdExchange application server

From tomcat:7
MAINTAINER James Whetstone <jwhetstone@ccctechcenter.org>
LABEL Description="This image is used to build the EdExchange application server. Although it can be created using normal docker commands, it's intended use is in conjunction with the proxy server image and the database image using docker compose as described in the README.md"

ENV JAVA_HOME /usr

# add the virtual directory from the host
RUN mkdir /opt/edexchange

# the context file will have the resource connection
ADD ./context.xml /usr/local/tomcat/conf/context.xml

# needed to connect the database
ADD ./mariadb-java-client-1.1.7.jar /usr/local/tomcat/lib/mariadb-java-client-1.1.7.jar

EXPOSE 8009
EXPOSE 8080

# development scripts
ADD ./tomcat-start.sh /opt/tomcat-start.sh
ADD ./tomcat-stop.sh /opt/tomcat-stop.sh
ADD ./webapp-deploy.sh /opt/webapp-deploy.sh
ADD ./webapp-remove.sh /opt/webapp-remove.sh
ADD ./directory_server.xml /usr/local/tomcat/conf/Catalina/localhost/directory_server.xml

CMD /usr/local/tomcat/bin/catalina.sh run
