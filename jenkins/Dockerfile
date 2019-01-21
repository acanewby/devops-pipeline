FROM jenkinsci/blueocean:1.9.0

# ------- as root --------------

USER root

# Add Docker repo
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories

RUN apk update \
      && apk add sudo curl docker

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# General environment setup
ENV SCRATCH /scratch
WORKDIR ${SCRATCH}

# ------- JDKs --------------

RUN curl -L -o ./zulu-jdk-11.tar.gz https://cdn.azul.com/zulu/bin/zulu11.2.3-jdk11.0.1-linux_musl_x64.tar.gz
RUN curl -L -o ./zulu-jdk-8.tar.gz https://cdn.azul.com/zulu/bin/zulu8.33.0.1-jdk8.0.192-linux_musl_x64.tar.gz

WORKDIR /opt/java/jdk

RUN tar -xvzf ${SCRATCH}/zulu-jdk-11.tar.gz
RUN ln -s ./zulu11.2.3-jdk11.0.1-linux_musl_x64 11
RUN rm -f ${SCRATCH}/zulu-jdk-11.tar.gz

RUN tar -xvzf ${SCRATCH}/zulu-jdk-8.tar.gz
RUN ln -s ./zulu8.33.0.1-jdk8.0.192-linux_musl_x64 8
RUN rm -f ${SCRATCH}/zulu-jdk-8.tar.gz

ENV JAVA_HOME /opt/java/jdk/8
ENV PATH ${JAVA_HOME}/bin:$PATH

# ------- as jenkins --------------

# Configure Jenkins
USER jenkins

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# Set basic configuration (mainly, disable security)
COPY config.xml /usr/share/jenkins/ref/config.xml

# Credentials (for Nexus user)
# COPY credentials.xml /usr/share/jenkins/ref/credentials.xml

# Configure Docker
# COPY org.jenkinsci.plugins.docker.commons.tools.DockerTool.xml /usr/share/jenkins/ref/org.jenkinsci.plugins.docker.commons.tools.DockerTool.xml

# Configure Maven
# COPY hudson.tasks.Maven.xml /usr/share/jenkins/ref/hudson.tasks.Maven.xml

# Configure SonarQube
COPY hudson.plugins.sonar.SonarGlobalConfiguration.xml /usr/share/jenkins/ref/hudson.plugins.sonar.SonarGlobalConfiguration.xml