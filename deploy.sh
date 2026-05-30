#!/bin/bash

# Helper script to deploy Jenkins to minikube cluster.

if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed or not in PATH."
    echo "Install kubectl from: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

if ! kubectl get namespace jenkins &> /dev/null; then
    kubectl create namespace jenkins
fi

kubectl apply -f deployment/