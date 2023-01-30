# enable the loadbalancer, give priv range such as 10.50.100.5 to 10.50.100.25 
# (make public if you want service to be accessible over internet)
microk8s enable metallb

# enable ingress
microk8s enable ingress 

sudo docker build . -t frontendapp:local
docker save frontendapp:local > /tmp/frontendapp.tar

microk8s ctr images import /tmp/frontendapp.tar 

microk8s kubectl delete networkpolicy frontend-network-policy
microk8s kubectl create -f networkpolicy.yaml

microk8s kubectl delete ingress frontendapp-ingress
microk8s kubectl delete deploy frontendapp
sleep 2;

microk8s kubectl create -f frontendapp_deployment.yaml
microk8s kubectl delete svc frontendapp-lb
sleep 2;

microk8s kubectl apply -f frontendapp_service_lb.yaml

# Create Ingress
microk8s kubectl apply -f frontendapp_ingress.yaml

microk8s kubectl get svc frontendapp-lb   
microk8s kubectl describe ingress frontendapp-ingress

microk8s kubectl autoscale deployment frontendapp --cpu-percent=50 --min=1 --max=10



