#!/bin/bash -x
APP_NAME=ping-exporter
REGION=us-east-03
CLUSTER=54952e-dm1
APP_SUITE_DIR=../../../../../k8s-services/argocd-app-suites/
HELMDIR=..
META_NAME=${APP_NAME}-${CLUSTER}
NAMESPACE=${APP_NAME}
CHART=`pwd`

cd ${APP_SUITE_DIR}
helm template . --values=values.yaml \
    --values=values-base-customer.yaml \
    --values=values-base-${REGION}.yaml \
    --values=values-${REGION}-${CLUSTER}.yaml \
    | yq '. | select(.metadata.name=="ping-exporter-54952e-dm1") | .spec.source.helm.values' > /tmp/1
# Then run your helm template:
cd $CHART
helm template $META_NAME $HELMDIR -n $NAMESPACE --values=/tmp/1  --debug
