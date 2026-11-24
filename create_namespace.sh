#!/bin/bash

. ./config.sh

print_command "${kubectl_cmd} create new-project ${namespace}\n"

if ${kubectl_cmd} get namespace "$namespace" >/dev/null 2>&1; then
  echo "Namespace '$namespace' already exists."
  #new-project switches the context, the script expect this to create the s3 creds in this ns
  ${kubectl_cmd} project ${namespace}
else
  echo "Namespace '${namespace}' does not exist. Creating it..."
  ${kubectl_cmd} new-project ${namespace}
  echo "Namespace '${namespace}' created successfully."
fi
