FROM sonatype/nexus3:3.20.1
# Install required packages
USER root
RUN yum install -y openssl curl ca-certificates sudo && \
    update-ca-trust force-enable

# Gives nexus sudoer privilege
RUN echo "nexus ALL=NOPASSWD: ALL" >> /etc/sudoers

# General environment setup
ENV SCRATCH=/scratch
RUN mkdir -p ${SCRATCH}

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
EXPOSE 8400 8401 8500 8501

# Set up a log file
ENV STARTUP_LOG ${SCRATCH}/startup.log
RUN touch $STARTUP_LOG && chmod a+rw $STARTUP_LOG

# Back to default user
USER nexus
WORKDIR ${SCRATCH}
ENV NEXUS_USR admin
ENV NEXUS_PW admin123
ENV NEXUS_PORT 8400

# Does what it says on the tin ...
ENTRYPOINT ${SCRATCH}/configure-and-launch-nexus


