sudo docker build . -t my-postgres:local
sudo docker save my-postgres:local > /tmp/my-postgres.tar
microk8s ctr images import /tmp/my-postgres.tar

microk8s kubectl delete deploy my-postgres
microk8s kubectl delete svc my-postgres
#microk8s kubectl delete pvc database-pvc
#microk8s kubectl delete pv database-pv
microk8s kubectl delete secret postgres-secret
microk8s kubectl delete cm postgres-cm
microk8s kubectl delete networkpolicy database-network-policy
sleep 5;
microk8s kubectl create -f networkpolicy.yaml
microk8s kubectl create -f persistentvolume.yaml
microk8s kubectl create -f persistentvolumeclaim.yaml
microk8s kubectl create -f secret.yaml
microk8s kubectl create -f configmap.yaml
microk8s kubectl create -f deployment.yaml
microk8s kubectl create -f service.yaml
sleep 5;

microk8s kubectl get svc my-postgres
