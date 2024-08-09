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
# - Set locale
# - Install desired packages
#
FROM ${projectDockerRegistry}/library/oraclelinux AS stage1

# Set the locale manually to a set inherited from the base image (defaults to POSIX)
ENV LANG=C.utf8

# Update the OS packages
RUN microdnf -y --refresh upgrade && \
    microdnf -y install postgresql procps && \
    microdnf clean all

#
# Stage 2: Compile su-exec
#
FROM stage1 AS stage2

RUN microdnf -y install gcc && \
    microdnf clean all

COPY maven/su-exec.c /usr/local/bin/su-exec.c

RUN gcc -Wall /usr/local/bin/su-exec.c -o /usr/local/bin/su-exec && \
    chmod +x /usr/local/bin/su-exec && \
    rm /usr/local/bin/su-exec.c

#
# Stage 3: Gather up any files to be added to the image
#
FROM stage1 AS stage3

# Copy the scripts and startup folders over from the opensuse base image
COPY --from=${projectDockerRegistry}/cafapi/opensuse-base /scripts /wd/scripts
COPY --from=${projectDockerRegistry}/cafapi/opensuse-base /startup /wd/startup

# Copy su-exec
COPY --from=stage2 /usr/local/bin/su-exec /wd/usr/local/bin/su-exec

# Add Tini
COPY maven/tini /wd
RUN chmod 711 /wd/tini

#
# Stage 4: The remainder of the actual image definition
#
FROM stage1

# Add the files that have been gathered up to the image
COPY --from=stage3 /wd /

# Set the default entrypoint
ENTRYPOINT ["/tini", "--", "/startup/startup.sh"]
