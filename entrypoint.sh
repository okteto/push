#!/bin/sh
set -e

namespace=$1
name=$2
deploy=$3
wd=$4

params=""

if [ ! -z "$OKTETO_CA_CERT" ]; then
   echo "Custom certificate is provided"
   echo "$OKTETO_CA_CERT" > /usr/local/share/ca-certificates/okteto_ca_cert
   update-ca-certificates
fi

if [ ! -z "$namespace" ]; then
params="${params} --namespace $namespace"
fi

if [ ! -z "$name" ]; then
params="${params} --name $name"
fi

if [ "$deploy" == "true" ]; then
params="${params} --deploy"
fi

if [ ! -z "$wd" ]; then
cd $wd
fi

echo running: okteto push $params on $(pwd)
okteto push $params