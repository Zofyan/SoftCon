#!/bin/bash
POD_NAME=$(microk8s kubectl get pods --namespace default -l "app.kubernetes.io/name=chart,app.kubernetes.io/instance=$1" -o jsonpath="{.items[0].metadata.name}")
echo "Pod $POD_NAME is running on"
CONTAINER_PORT=$(microk8s kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
echo "$CONTAINER_PORT"
echo "Visit http://127.0.0.1:8080 to use your application"
microk8s kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
