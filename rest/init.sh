sudo docker build . -t rest-api:local
sudo docker save rest-api:local > /tmp/rest-api.tar
microk8s ctr images import /tmp/rest-api.tar

microk8s kubectl apply -f networkpolicy.yaml
microk8s kubectl delete -f config.yaml
microk8s kubectl apply -f config.yaml
microk8s kubectl apply -f rest_service_lb.yaml
