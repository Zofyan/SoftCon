#!/bin/bash
# run this before installing the helm script.
# will cleanup some things before helm install
# will delete everything!

# if the pv / pvc gets stuck on being deleted, then do 
# kubectl edit pv x (where x is either the PV or PVC)
# then find the lines 

# finalizers:
#   -  kubernetes.io/pv-protection 

# and delete them

if [ "$1" = "no_microk8s" ]; then
	kubectl delete all --all
	kubectl delete np database-network-policy
	kubectl delete networkpolicy database-network-policy
	kubectl delete networkpolicy frontend-network-policy
	kubectl delete networkpolicy rest-network-policy
	kubectl delete secret postgres-secret
	kubectl delete configmap postgres-cm 
	kubectl delete pvc --all
	kubectl delete pv --all
	kubectl delete clusterrole deployment-manager-cr 
	kubectl delete clusterrole standard-user-cr 
	kubectl delete clusterrole superuser-cr 
	kubectl delete clusterrolebinding deployment-manager-crb
	kubectl delete clusterrolebinding superuser-crb
	kubectl delete clusterrolebinding standard-user-crb
else
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
fi



