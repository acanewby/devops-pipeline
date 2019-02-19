FROM sonatype/nexus3:3.15.2

# Install required packages
USER root
RUN yum install -y openssl curl ca-certificates && \
    update-ca-trust force-enable

# Gives nexus sudoer privilege
RUN echo "nexus ALL=NOPASSWD: ALL" >> /etc/sudoers

# General environment setup
ARG SCRATCH=/scratch
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

# Stage Nexus config items
COPY configure-and-launch-nexus.sh ${SCRATCH}
COPY nexus.properties ${SCRATCH}
RUN chmod a+x ${SCRATCH}/configure-and-launch-nexus.sh
EXPOSE 8443

# Back to default user
USER nexus
WORKDIR ${SCRATCH}
CMD ["sh", "-c", "/scratch/configure-and-launch-nexus.sh"]
