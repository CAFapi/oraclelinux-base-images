#
# Copyright 2024-2026 Open Text.
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

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Override the inherited startup entrypoint so shell startup scripts are sourced
# in the parent shell and can export env vars for the final Java process.
COPY startup.sh /startup/startup.sh

# Copy OpenTelemetry Java agent
COPY maven/otel/opentelemetry-javaagent.jar /maven/otel/opentelemetry-javaagent.jar

# Copy OpenTelemetry startup script
COPY enable-otel-javaagent.sh /startup/startup.d/20-enable-otel-javaagent.sh
RUN chmod a+rx /startup/startup.sh
RUN chmod a+rx /startup/startup.d/20-enable-otel-javaagent.sh

ENV OTEL_JAVAAGENT_ENABLED=true \
    OTEL_TRACES_EXPORTER=otlp \
    OTEL_EXPORTER_OTLP_ENDPOINT=http://host.docker.internal:18889 \
    OTEL_EXPORTER_OTLP_PROTOCOL=grpc
