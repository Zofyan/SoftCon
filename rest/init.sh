sudo docker build . -t rest-api:local
sudo docker save rest-api:local > rest-api.tar
microk8s ctr images import rest-api.tar

microk8s kubectl delete deploy rest &> /dev/null
microk8s kubectl delete svc rest &> /dev/null
sleep 2;
microk8s kubectl create -f config.yaml
sleep 2;

microk8s kubectl expose deploy rest --type=ClusterIP --port=8081 --target-port=1234

microk8s kubectl get svc rest
