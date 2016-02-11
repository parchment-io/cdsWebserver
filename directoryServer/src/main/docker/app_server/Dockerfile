# Dockerfile to build the EdExchange Directory Server

# To build the image
# docker build -t wowen/directory_server --no-cache .
# 
# To run a container
# 
# docker run -d -p 80:80 -p 3306:3306 --name edex-ds -v //local/path/to/source/:/opt/edexchange wowen/directory_server
# 
# Running scripts
# docker exec edex-ds //opt/tomcat-start.sh
# docker exec edex-ds //opt/webapp-deploy.sh
# 
# Usefull docker commands
# 
# This command will send the catalina.out log to your console, default directory
# the container's default directory is /usr/local/tomcat
# docker exec edex-ds tail -f logs/catalina.out
# 
# The `docker logs edex-ds` command will output the mariadb logs

From tomcat:7
MAINTAINER Wes Owen <wowen@ccctechcenter.org>
LABEL Description="This image is used to build the EdExchange application server. It must be used in conjunction with the proxy server image and the database image using docker composse"

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

CMD /usr/local/tomcat/bin/catalina.sh run
