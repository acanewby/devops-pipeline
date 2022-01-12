FROM jenkinsci/blueocean:1.24.7

# ------- as root --------------

USER root

# Update repos and add some important packages
RUN apk update && apk add sudo curl

# General environment
ENV SCRATCH /scratch
WORKDIR ${SCRATCH}

# ------- Alpine JDKs --------------

ENV ZULU8_VER 8.33.0.1
ENV JDK8_BUILD 8.0.192

ENV ZULU11_VER 11.2.3
ENV JDK11_BUILD 11.0.1

RUN curl -L -o ./zulu-jdk-11.tar.gz https://cdn.azul.com/zulu/bin/zulu${ZULU11_VER}-jdk${JDK11_BUILD}-linux_musl_x64.tar.gz
RUN curl -L -o ./zulu-jdk-8.tar.gz https://cdn.azul.com/zulu/bin/zulu${ZULU8_VER}-jdk${JDK8_BUILD}-linux_musl_x64.tar.gz

WORKDIR /opt/java/jdk

RUN tar -xvzf ${SCRATCH}/zulu-jdk-11.tar.gz
RUN ln -s ./zulu${ZULU11_VER}-jdk${JDK11_BUILD}-linux_musl_x64 11
RUN rm -f ${SCRATCH}/zulu-jdk-11.tar.gz

RUN tar -xvzf ${SCRATCH}/zulu-jdk-8.tar.gz
RUN ln -s ./zulu${ZULU8_VER}-jdk${JDK8_BUILD}-linux_musl_x64 8
RUN rm -f ${SCRATCH}/zulu-jdk-8.tar.gz

ENV JAVA_HOME /opt/java/jdk/8
ENV PATH ${JAVA_HOME}/bin:$PATH


# ------- set jenkins user privs --------

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN adduser jenkins docker

# ------- Configure Jenkins --------------

USER jenkins

# Install plugins

# Run this script at http://localhost:18080/script
#
# Jenkins.instance.pluginManager.plugins.each{
#  plugin ->
#    println ("${plugin.getShortName()}:${plugin.getVersion()}")
#}
COPY plugins.txt /tmp/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /tmp/plugins.txt

# Set basic configuration (mainly, disable security)
COPY config.xml /usr/share/jenkins/ref/config.xml

# Configure Nexus
COPY credentials.xml /usr/share/jenkins/ref/credentials.xml
COPY org.sonatype.nexus.ci.config.GlobalNexusConfiguration.xml /usr/share/jenkins/ref/org.sonatype.nexus.ci.config.GlobalNexusConfiguration.xml

# Configure SonarQube
COPY hudson.plugins.sonar.SonarGlobalConfiguration.xml /usr/share/jenkins/ref/hudson.plugins.sonar.SonarGlobalConfiguration.xml


# ----------- Configure and launch Jenkins --------------------

USER root
WORKDIR ${SCRATCH}
COPY configure-and-launch-jenkins ${SCRATCH}/
RUN /bin/chmod a+x ${SCRATCH}/configure-and-launch-jenkins
ENTRYPOINT ${SCRATCH}/configure-and-launch-jenkins

