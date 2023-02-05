sudo docker build . -t my-postgres:local
sudo docker save my-postgres:local > /tmp/my-postgres.tar
microk8s ctr images import /tmp/my-postgres.tar

microk8s kubectl apply -f networkpolicy.yaml
microk8s kubectl apply -f persistentvolume.yaml
microk8s kubectl apply -f persistentvolumeclaim.yaml
microk8s kubectl apply -f secret.yaml
microk8s kubectl apply -f configmap.yaml
microk8s kubectl delete -f deployment.yaml
microk8s kubectl apply -f deployment.yaml
microk8s kubectl apply -f service.yaml
sleep 5;

microk8s kubectl get svc my-postgres
