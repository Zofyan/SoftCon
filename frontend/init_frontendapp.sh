#!/bin/bash
microk8s enable metallb

microk8s enable ingress 

sudo docker build . -t frontendapp:local
docker save frontendapp:local > /tmp/frontendapp.tar

microk8s ctr images import /tmp/frontendapp.tar 

microk8s kubectl apply -f networkpolicy.yaml
microk8s kubectl delete -f frontendapp_deployment.yaml
microk8s kubectl apply -f frontendapp_deployment.yaml
microk8s kubectl apply -f frontendapp_service_lb.yaml

microk8s kubectl autoscale deployment frontendapp --cpu-percent=50 --min=1 --max=10



