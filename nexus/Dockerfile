FROM sonatype/nexus3:3.15.2

# Install required packages
USER root
RUN yum install -y openssl curl ca-certificates sudo && \
    update-ca-trust force-enable

# Gives nexus sudoer privilege
RUN echo "nexus ALL=NOPASSWD: ALL" >> /etc/sudoers

# General environment setup
ENV SCRATCH=/scratch
ARG JDK_VER=8
ARG JDK_ARCHIVE=${SCRATCH}/jdk-${JDK_VER}.tar.gz

WORKDIR /opt/java/jdk

# Install OpenJDK
RUN mkdir -p ${SCRATCH} && \
    curl --location --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz -o ${JDK_ARCHIVE} && \
    tar -xvzf ${JDK_ARCHIVE} && \
    ln -s ./jdk1.8.0_202/ $JDK_VER && \
    rm -f ${JDK_ARCHIVE}

ENV JAVA_HOME /opt/java/jdk/$JDK_VER
ENV PATH ${JAVA_HOME}/bin:$PATH

ARG TRIGGER=6

# Install some utilities
ENV NEXUS_UTIL /opt/nexus-util
RUN mkdir -p $NEXUS_UTIL
ENV PATH ${NEXUS_UTIL}:$PATH
COPY util/nexus-script-* ${NEXUS_UTIL}/
RUN chmod a+x ${NEXUS_UTIL}/nexus-script-*

# Stage Nexus config items
COPY configure-and-launch-nexus ${SCRATCH}
COPY nexus.properties ${SCRATCH}
COPY *.json ${SCRATCH}/
RUN chmod a+x ${SCRATCH}/configure-and-launch-nexus
EXPOSE 8443 8500 8501

# Set up a log file
ENV STARTUP_LOG ${SCRATCH}/startup.log
RUN touch $STARTUP_LOG && chmod a+rw $STARTUP_LOG

# Back to default user
USER nexus
WORKDIR ${SCRATCH}
ENV NEXUS_USR admin
ENV NEXUS_PW admin123
ENV NEXUS_PORT 8081
ENTRYPOINT ${SCRATCH}/configure-and-launch-nexus


