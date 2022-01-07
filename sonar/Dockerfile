FROM sonarqube:9.2-community

USER root

# Update repos and add some important packages
RUN apk update && apk add sudo curl

ENV SCRATCH=/scratch
RUN mkdir -p $SCRATCH

# Deploy config script
COPY configure-and-launch-sonar ${SCRATCH}/
RUN chmod a+x ${SCRATCH}/configure-and-launch-sonar

# Set up a log file
ENV STARTUP_LOG ${SCRATCH}/startup.log
RUN touch $STARTUP_LOG && chmod a+rw $STARTUP_LOG

# Configure and launch sonarqube
USER sonarqube

ENV SONAR_USR admin
ENV SONAR_PW admin
ENV SONAR_PORT 9000

ARG TRIGGER=5
WORKDIR $SCRATCH
ENTRYPOINT ["./configure-and-launch-sonar"]