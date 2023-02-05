#!/bin/bash
microk8s enable dns storage cert-manager
microk8s kubectl apply -f ingress.yaml
microk8s kubectl apply -f clusterissuer.yaml
microk8s kubectl apply -f root_cert.yaml
microk8s kubectl apply -f issuer.yaml
microk8s kubectl get secret root-secret -o jsonpath='{.data}' | cut -c12-771 | base64 -d > root_ca.pem

cd database
sudo sh init.sh
cd ../rest
sudo sh init.sh
cd ../frontend
sudo sh init_frontendapp.sh
cd ../rbac
sudo sh init_rbac.sh
