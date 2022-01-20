K8S_NAMESPACE=sekur
K8S_HELM_RELEASE_NAME=app
K8S_HELM_CHARTS_DIR=./deploy
TOOLS_DIR=./tools

kube-start:
    minikube start

kube-stop:
    minikube stop

kube-tunnel:
    minikube tunnel

helm-install:
	helm install -n $(K8S_NAMESPACE) $(K8S_HELM_RELEASE_NAME) $(K8S_HELM_CHARTS_DIR)

helm-upgrade:
	helm upgrade -n $(K8S_NAMESPACE) $(K8S_HELM_RELEASE_NAME) $(K8S_HELM_CHARTS_DIR)

helm-uninstall:
	helm uninstall -n $(K8S_NAMESPACE) $(K8S_HELM_RELEASE_NAME)

run-init:
	$(TOOLS_DIR)/init.sh

init:
	kubectl create namespace $(K8S_NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	make run-init
