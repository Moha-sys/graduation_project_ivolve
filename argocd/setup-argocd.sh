#!/bin/bash
# Setup ArgoCD on Kubernetes Cluster and Register Project Application
set -e

echo "=========================================================="
echo " Installing ArgoCD on Kubernetes Cluster                  "
echo "=========================================================="

# Create argocd namespace
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

# Install official ArgoCD manifests
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD server pods to be ready..."
kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s || true

# Apply Project Application
echo "Deploying iVolve Application to ArgoCD..."
kubectl apply -f argocd/application.yaml

echo "=========================================================="
echo " ArgoCD setup completed successfully!                     "
echo " Initial Admin Password can be retrieved via:             "
echo " kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d "
echo "=========================================================="
