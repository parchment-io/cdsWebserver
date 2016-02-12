# EdExchange Directory Server docker configuration.

The images and docker compose configuration is intended to provide an environment for developers.

The idea here is that a developer can pull the GIT repository, run "docker-compose up" and then begin
actual work on the code using whatever tools the developer prefers.  Deployment of the code changes is
simply done by invoking maven:  "mvn -Denv=ci package".

How it works

The EdExchange Docker configuration consists of 3 images:

- The application server is based on the tomcat:7 image
- The database server is based on the debian:8.3 image where the Dockerfile installs and configures
mariadb 10.0 by creating a user ccctc/ccc.dev as the username and password.
- The proxy server based in the debian:8.3 image where the Dockerfile installs and configures apache
and the AJP extension so that requests for the app server are forwarded to the app server.

Pre-requisites:
1) Docker
2) Docker compose
3) Java
4) Maven

Developer work flow:
1) Clone the GIT repo

2) From the root of the GIT repo, invoke docker compose:  "docker-compose up".  This will build the images, create
and run the containers.  The first time this is invoked, new images will probably be downloaded, so expect this step
to take a few minutes at least.  The end result of this command is that the 3 related docker containers will be running
and the current console window will display output from the app server (tomcat).  The last statement in the console window
should be similar to "edex-ds-app   | INFO: Server startup in 7142 ms"

3) Verify that all the containers have been started: from the root of the GIT repo, run "docker-compose ps".  This should
result in output simlar to the following:

    Name                   Command               State                Ports
-----------------------------------------------------------------------------------------
edex-ds-app     /bin/sh -c /usr/local/tomc ...   Up      8009/tcp, 0.0.0.0:8080->8080/tcp
edex-ds-db      /bin/sh -c exec mysqld_safe      Up      3306/tcp
edex-ds-proxy   /bin/sh -c /usr/sbin/apach ...   Up      443/tcp, 0.0.0.0:80->80/tcp

If your output shows that one or more of the containers are not running, something failed.  You can look back at the
console output from "docker-compose up".  Error messages in red should describe related issues. You and also look at
apache log files which are mounted at ./docker_container_data/edex-ds-proxy/logs

4) At this point, your containers are running, but the directory server still needs to be deployed to the app server
container and the database initialized.  For this step, invoke "mvn -Denv=ci clean package".  This will create the
required database on the database server (edex-ds-db) and deploy the app to the app server (edex-ds-app).  You can
optionally just run the "deploy.sh" script in the root directory.

5) Verify that you can browse to the app server.  For this step, you should verify that
"http://172.17.0.4/directory_server/login" renders the directory server's login page.  Note that by default, if no
other docker containers were running before invoking "docker-compose up", docker will use the following IP addresses:

172.17.0.1 is the default docker gateway.
172.17.0.2 is the database server address.  This is the container named "edex-ds-db"
172.17.0.3 is the application server address.  This is the container named "edex-ds-app"
172.17.0.4 is the proxy serve address.  This is the container named "edex-ds-proxy"

You can optionally edit your hosts file and add an entry for the proxy server.

6) Now you're ready to start developing.  Whenever you're ready to deploy and test your changes, you'll need to
invoke "mvn -Denv=ci package" again.  You should not have to shutdown the containers during development, but when
you need to shut them down, use "docker-container stop" from a new terminal window.  Again, this must be invoked
from the root of the GIT repo, where the docker-compose.yml file exists.


