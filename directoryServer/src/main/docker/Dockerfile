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
LABEL Description="This image is used to build the EdExchange Directory Server"

ENV JAVA_HOME /usr

RUN apt-get -y update && apt-get install -y apache2
RUN apt-get clean

# adds the ServerName value to the apache config
RUN echo "ServerName EdExchange" >> /etc/apache2/apache2.conf

EXPOSE 80

# add the virtual directory from the host
RUN mkdir /opt/edexchange

# this has the ajp proxy directives in it
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod proxy_ajp

# the context file will have the resource connection
ADD ./context.xml /usr/local/tomcat/conf/context.xml

# needed to connect the database
ADD ./mariadb-java-client-1.1.7.jar /usr/local/tomcat/lib/mariadb-java-client-1.1.7.jar

# development scripts
ADD ./tomcat-start.sh /opt/tomcat-start.sh
ADD ./tomcat-stop.sh /opt/tomcat-stop.sh
ADD ./webapp-deploy.sh /opt/webapp-deploy.sh
ADD ./webapp-remove.sh /opt/webapp-remove.sh

# multi-application startup
ADD ./startup.sh /opt/startup.sh

CMD /opt/startup.sh
