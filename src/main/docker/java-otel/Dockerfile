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

# Copy OpenTelemetry Java agent
COPY maven/otel/opentelemetry-javaagent.jar /opt/otel/opentelemetry-javaagent.jar

# Copy OpenTelemetry helper script
COPY get-otel-java-tool-options.sh /scripts/get-otel-java-tool-options.sh
RUN chmod a+rx /scripts/get-otel-java-tool-options.sh

# OTEL Java agent is disabled by default. Enable by setting OTEL_JAVAAGENT_ENABLED=true
ENV OTEL_JAVAAGENT_ENABLED=false \
    OTEL_TRACES_EXPORTER=otlp \
    OTEL_EXPORTER_OTLP_PROTOCOL=grpc \
    OTEL_GET_JAVA_TOOL_OPTIONS=/scripts/get-otel-java-tool-options.sh
