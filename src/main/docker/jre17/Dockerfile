#
# Copyright 2024 Open Text.
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
# - Install Java 17 Runtime
#
ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS stage1

# Install OpenJDK 21 Runtime Environment
RUN microdnf -y install java-17-openjdk && \
    microdnf clean all

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

# Set JRE Home
ENV JRE_HOME=/etc/alternatives/jre_17_openjdk
