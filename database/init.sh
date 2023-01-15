sudo docker build . -t my-postgres:local
sudo docker save my-postgres:local > my-postgres.tar
microk8s ctr images import my-postgres.tar

microk8s kubectl delete deploy database &> /dev/null
microk8s kubectl delete svc database &> /dev/null
sleep 2;
microk8s kubectl create -f config.yaml
sleep 2;

microk8s kubectl expose deploy database --type=ClusterIP --port=8081 --target-port=5432

microk8s kubectl get svc database
