#!/bin/bash

if [ "$1" = "no_microk8s" ]; then
	helm install chart chart
    kubectl get secret root-secret -o jsonpath='{.data}' | cut -c12-771 | base64 -d > root_ca.pem
else
	microk8s helm3 install chart chart
	microk8s kubectl get secret root-secret -o jsonpath='{.data}' | cut -c12-771 | base64 -d > root_ca.pem
fi
