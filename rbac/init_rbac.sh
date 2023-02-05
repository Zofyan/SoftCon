#!/bin/bash
# make sure that your hostname does not contain  capital 
# letters or underscores if node is not ready when
# RBAC is enabled (see https://microk8s.io/docs/troubleshooting, common issues)

microk8s enable rbac
microk8s kubectl apply -f standard-user-cr.yaml 
microk8s kubectl apply -f standard-user-crb.yaml 
microk8s kubectl apply -f deployment-manager-cr.yaml 
microk8s kubectl apply -f deployment-manager-crb.yaml 
microk8s kubectl apply -f superuser-cr.yaml 
microk8s kubectl apply -f superuser-crb.yaml 


