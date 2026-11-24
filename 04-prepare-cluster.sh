#!/bin/bash

. ./config.sh
. ./commands.sh

#Doc
echo "04" > ./docs/docid

# Create namespace if does not exists
. ./create_namespace.sh
if [ $(grep ACCESS_SECRET config.sh | cut -f2 -d"=" | tr -d '"') == "edbworkshop" ]; then
 print_error "=======================================================\n" 
 print_error "You didn't update the pass!!!\n" 
 print_error "Go go to config.sh and change the minio password\n"
 print_error "$(grep -n ACCESS_SECRET config.sh)\n"
 print_error "=======================================================\n"
else

if [ "$object_storage_type" == "aws" ]; then
  print_info "=======================================================\n"
  print_info "AWS secrets\n"
  print_info "-----------\n"
  print_info "Make sure that your AWS credentials are up to date.\n"
  print_info "If this is not the case, please add it in ${yellow}.aws.sh${reset} ${blue}file.\n"
  print_info "=======================================================\n"
  . ./aws_secrets.sh
elif [ "$object_storage_type" == "minio" ]; then
  print_info "Minio secrets configuration...\n"
  
  print_command "${kubectl_cmd} delete secret minio-creds\n"

  ${kubectl_cmd} delete secret minio-creds
  
  print_command "${kubectl_cmd} create secret generic minio-creds \\
    --from-literal=ACCESS_KEY_ID=${ACCESS_KEY_ID} \\
    --from-literal=ACCESS_SECRET_KEY=${ACCESS_SECRET_KEY}\n"

  ${kubectl_cmd} create secret generic minio-creds \
    --from-literal=ACCESS_KEY_ID=${ACCESS_KEY_ID} \
    --from-literal=ACCESS_SECRET_KEY=${ACCESS_SECRET_KEY}
fi

fi

# Set context
./set_context.sh
