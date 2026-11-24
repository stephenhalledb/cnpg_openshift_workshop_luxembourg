#!/bin/bash

git_directory=`git rev-parse --show-toplevel`
. ${git_directory}/commands.sh

#. ./commands.sh

export TMP=${HOME}/tmp
[ -d $TMP ] || mkdir $TMP
echo "Find the YAML-files in $TMP"

# Variables to be replaced
export id="$(oc whoami)"          # your name or id
export region="emea"              # emea,na,apj
export bucket="backups"     # S3 bucket name

# Kubernetes environment
export namespace="edb-${region}-${id}"   # k8s namespace (project) of the demo
export kubectl_cmd="oc"                  # command used to talk to the cluster
export kubectl_cnp="kubectl-cnp"         # CloudNativePG kubectl plugin

# Postgres
export cluster_name="cluster-${id}"
export cluster_restore="cluster-restore-${id}"


# --- Postgres clusters: size & ressoucres ---------------------------------------

export postgres_instances=3                      # number of instances (1 primary + replicas)
export postgres_cpu="0.1"                        # default value for workshop 0.1
export postgres_cpu_max="0.5"                    # default value for workshop 0.5

export postgres_memory="256Mi"                   # default value for workshop 256Mi
export postgres_memory_max="512Mi"               # default value for workshop 512Mi
export postgres_storage="512Mi"                  # default value for workshop 512Mi
export postgres_wal_storage="512Mi"              # default value for workshop 512Mi


# Using Docker repository

## List version images

# ---
# EDB Postgres
export postgres_default_image="docker.enterprisedb.com/k8s/postgresql:17.6"
export postgres_upgrade_image="docker.enterprisedb.com/k8s/postgresql:17.7"
export postgres_major_upgrade_image="docker.enterprisedb.com/k8s/postgresql:18"

# EDB Postgres Extended
#export postgres_default_image="docker.enterprisedb.com/k8s/edb-postgres-extended:17.6"
#export postgres_upgrade_image="docker.enterprisedb.com/k8s/edb-postgres-extended:17.7"

# EDB Postgres Advanced Server
#export postgres_default_image="docker.enterprisedb.com/k8s/edb-postgres-advanced:17.6"
#export postgres_upgrade_image="docker.enterprisedb.com/k8s/edb-postgres-advanced:17.7"
# ---

# Major upgrade
export postgres_major_upgrade_image="docker.enterprisedb.com/k8s/postgresql:18.1"

# EPAS
export epas_image="docker.enterprisedb.com/k8s/edb-postgres-advanced:17.7"
export epas_storage="512Mi"

# Object Storage environment [minio|aws]
export object_storage_type="minio"

# MinIO
export ACCESS_KEY_ID="minio"
export ACCESS_SECRET_KEY="edbworkshop"
export ACCESS_SESSION_TOKEN=""
export object_storage_bucket="${bucket}"
export s3_destination_path="s3://${bucket}/"

## S3
#export object_storage_bucket="${bucket}"
#export s3_destination_path="s3://${bucket}/"
export s3_endpoint_url="http://minio-service.minio.svc.cluster.local:9000/"


# TDE used
# Not yet implemented
export use_tde="N" # Y|N

# Affinity (useful when using Power machines)
# export affinity=$(cat <<EOF
#   affinity:
#     nodeAffinity:
#       requiredDuringSchedulingIgnoredDuringExecution:
#         nodeSelectorTerms:
#           - matchExpressions:
#               - key: machine_type
#                 operator: In
#                 values:
#                   - power
# EOF
#)
