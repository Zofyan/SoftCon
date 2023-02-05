#!/bin/bash
# run this before installing the helm script.
# will cleanup some things before helm install
# will delete everything!

microk8s kubectl delete all --all
microk8s kubectl delete np database-network-policy
microk8s kubectl delete networkpolicy database-network-policy
microk8s kubectl delete networkpolicy frontend-network-policy
microk8s kubectl delete networkpolicy rest-network-policy
microk8s kubectl delete secret postgres-secret
microk8s kubectl delete configmap postgres-cm 
microk8s kubectl delete pvc --all
microk8s kubectl delete pv --all
microk8s kubectl delete clusterrole deployment-manager-cr 
microk8s kubectl delete clusterrole standard-user-cr 
microk8s kubectl delete clusterrole superuser-cr 
microk8s kubectl delete clusterrolebinding deployment-manager-crb
microk8s kubectl delete clusterrolebinding superuser-crb
microk8s kubectl delete clusterrolebinding standard-user-crb