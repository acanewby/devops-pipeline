#!/bin/bash

# The following env vars should be defined by the source image
echo "===================================================="
echo "Nexus environment"
echo "----------------------------------------------------"
echo "SONATYPE_DIR : ${SONATYPE_DIR}"
echo "SONATYPE_WORK: ${SONATYPE_WORK}"
echo "NEXUS_HOME   : ${NEXUS_HOME}"
echo "NEXUS_DATA   : ${NEXUS_DATA}"
echo "----------------------------------------------------"
echo "PATH         : ${PATH}"
echo "===================================================="

while [ ! -d ${NEXUS_DATA}/log ]; do
    echo "Waiting for Nexus data volume mount ..."
    sleep 2
done

# Generate SSL keystore
NEXUS_HOST=nexus
NEXUS_PORT=8443
JKS_PW=password

echo "Making keystore in ${NEXUS_DATA}/etc/ssl ..."
mkdir -p ${NEXUS_DATA}/etc/ssl

keytool -genkeypair \
    -keystore ${NEXUS_DATA}/etc/ssl/keystore.jks -storepass ${JKS_PW} \
    -keypass ${JKS_PW} -alias jetty -keyalg RSA -keysize 4096 -validity 3650 \
    -dname "CN=${NEXUS_HOST}, OU=acanewby, O=Sonatype, L=Unspecified, ST=Unspecified, C=US" \
    -ext "BC=ca:true"

# Trust the certificate
echo "Trust the certificate ..."
sudo keytool -exportcert -v \
    -keystore ${NEXUS_DATA}/etc/ssl/keystore.jks -storepass ${JKS_PW} \
    -rfc -alias jetty \
    -file /etc/pki/ca-trust/source/anchors/${NEXUS_HOST}.crt
sudo update-ca-trust

echo "Configuring Sonatype Nexus ..."
cp /scratch/nexus.properties ${NEXUS_DATA}/etc

echo "Launching Sonatype Nexus ..."
${SONATYPE_DIR}/start-nexus-repository-manager.sh