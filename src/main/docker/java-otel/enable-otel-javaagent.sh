#!/bin/bash
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

set -eu

OTEL_AGENT_PATH="/maven/otel/opentelemetry-javaagent.jar"

# Enabled by default for otel base images; runtime can still override to false.
OTEL_JAVAAGENT_ENABLED="${OTEL_JAVAAGENT_ENABLED:-true}"
export OTEL_JAVAAGENT_ENABLED

if [ "$OTEL_JAVAAGENT_ENABLED" = "true" ]; then
    if [ ! -f "$OTEL_AGENT_PATH" ]; then
        echo "ERROR: OTEL_JAVAAGENT_ENABLED=true but agent not found at $OTEL_AGENT_PATH" >&2
        exit 1
    fi

    case "${JAVA_TOOL_OPTIONS:-}" in
        *"-javaagent:${OTEL_AGENT_PATH}"*) ;;
        *) export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:-} -javaagent:${OTEL_AGENT_PATH}" ;;
    esac
fi
