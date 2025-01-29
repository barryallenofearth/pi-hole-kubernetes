#!/bin/bash
KUBERNETES_CONFIGS_PATH=~/git/pi-hole-kubernetes/k8s
shopt -s expand_aliases
alias kubectl='microk8s kubectl'

echo "configure base project definitions"
kubectl apply -f $KUBERNETES_CONFIGS_PATH

read -p -r "Enter pi-hole admin password:" password

echo "create admin password secret"
kubectl create secret generic pi-hole-admin --from-literal=password="$password" -n pi-hole

echo "Apply server settings"
kubectl apply -f $KUBERNETES_CONFIGS_PATH/server
