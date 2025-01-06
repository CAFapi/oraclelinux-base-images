#!/bin/bash
#
# Copyright 2025 Open Text.
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

JAVA_KEYSTORE_PASSWORD=${JAVA_KEYSTORE_PASSWORD:-changeit}

import_java_cert() {
    echo "Importing CA cert into Java Keystore"
    keytool -importcert -noprompt -alias caf-ssl-ca-cert-$2 -file $1 -cacerts -storepass $JAVA_KEYSTORE_PASSWORD
}

import_java_certs() {
    IFS=',' read -a caFiles <<< "$SSL_CA_CRT"

    index=0
    for caFile in "${caFiles[@]}"
    do
        if ! [ -e $SSL_CA_CRT_DIR/$caFile ]
        then
            echo "CA Certificate at '$SSL_CA_CRT_DIR/$caFile' not found"
            echo "Aborting further Java CA certificate load attempts."
            exit 1
        fi

        import_java_cert $SSL_CA_CRT_DIR/$caFile $index
	    (( index++ ))
        echo "CA Certificate '$caFile' added to cacerts"
    done
}

if [ -n "$SSL_CA_CRT_DIR" ] && [ -n "$SSL_CA_CRT" ]
then
    import_java_certs
else
    echo "Not installing CA Certificate for Java"
fi
