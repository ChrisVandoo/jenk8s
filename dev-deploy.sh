#!/bin/bash

###
# Checks that all the required tools exist to deploy Jenkins to minikube. Builds the local Jenkins image
# using minikube, creates the "jenkins" namespace if it doesn't exist, and deploys Jenkins to the local
# cluster.
###

set -euo pipefail

if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed or not in PATH."
    exit 1
fi

if ! command -v minikube &> /dev/null; then
    echo "Error: minikube is not installed or not in PATH."
    exit 1
fi

if ! minikube status &> /dev/null; then
    echo "minikube is not running. Starting minikube..."
    minikube start
fi

minikube image build ./images/jenkins -t jenkins-local:latest

if ! kubectl get namespace jenkins &> /dev/null; then
    kubectl create namespace jenkins
fi

kubectl apply -f deployment/