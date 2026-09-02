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

if [ -d /startup/startup.d ]
then
    for script in /startup/startup.d/*
    do
        if [ -f "$script" ] && [ -x "$script" ]
        then
            echo "Running startup script $script"

            case "$script" in
                */20-enable-otel-javaagent.sh)
                    . "$script"
                    ;;
                *)
                    "$script"
                    ;;
            esac
        fi
    done
fi

exec "$@"
