sudo docker build . -t rest-api:local
sudo docker save rest-api:local > /tmp/rest-api.tar
microk8s ctr images import /tmp/rest-api.tar

microk8s kubectl delete deploy rest
microk8s kubectl delete svc rest-lb
microk8s kubectl delete ingress rest-ingress
sleep 2;
microk8s kubectl create -f config.yaml
microk8s kubectl create -f rest_service_lb.yaml
microk8s kubectl create -f rest_ingress.yaml
sleep 2;

microk8s kubectl get svc rest
