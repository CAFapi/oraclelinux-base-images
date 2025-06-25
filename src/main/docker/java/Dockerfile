#
# Copyright 2024-2025 Open Text.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Stage 1
# - Install Java
#
ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS stage1

# Copy custom crypto-policy file
COPY DISABLE-CBC.pmod /etc/crypto-policies/policies/modules

# Install OpenJDK, disable weaker security algorithms, and update java.security file to fix
# SecureRandom.getInstanceStrong() not being available on a FIPS-enabled system (https://issues.redhat.com/browse/RHEL-3478)
ARG JAVA_VERSION
ARG JAVA_PACKAGE
RUN microdnf -y install java-${JAVA_VERSION}-${JAVA_PACKAGE} && \
    update-crypto-policies --set DEFAULT:DISABLE-CBC && \
    sed -ri -e '/^jdk.tls.disabledAlgorithms=/s/$/, TLS_DHE_RSA_WITH_CHACHA20_POLY1305_SHA256/' \
        /etc/crypto-policies/back-ends/java.config && \
    microdnf clean all && \
    sed -i 's/^securerandom\.strongAlgorithms=.*/securerandom.strongAlgorithms=PKCS11:SunPKCS11-NSS-FIPS/' \
        /etc/alternatives/jre_${JAVA_VERSION}_openjdk/conf/security/java.security

# Set JRE Home
ENV JRE_HOME=/etc/alternatives/jre_${JAVA_VERSION}_openjdk

#
# Stage 2: Gather up any files to be added to the image
#
FROM stage1 AS stage2

# Install Java certificate installation script
COPY install-ca-cert-java.sh /wd/startup/startup.d/
RUN chmod 711 /wd/startup/startup.d/install-ca-cert-java.sh

#
# Stage 3: The remainder of the actual image definition
#
FROM stage1

# Add the files that have been gathered up to the image
COPY --from=stage2 /wd /
