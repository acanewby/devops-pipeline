FROM jenkinsci/blueocean:1.9.0

# ------- as root --------------

USER root

RUN apk update \
      && apk add sudo curl

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Get docker-cli
RUN curl -sSL -o /bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest
RUN chmod +x /bin/docker

# ------- as jenkins --------------

# Configure Jenkins
USER jenkins

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# Set basic configuration (mainly, disable security)
COPY config.xml /usr/share/jenkins/ref/config.xml

# Credentials (for Nexus user)
COPY credentials.xml /usr/share/jenkins/ref/credentials.xml