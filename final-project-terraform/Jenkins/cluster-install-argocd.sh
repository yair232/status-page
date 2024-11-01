#!/bin/bash

# Variables
REGION="us-east-1"
CLUSTER_NAME="y-r-cluster"
NAMESPACE="argocd"
ARGOCD_MANIFEST="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"

# Update kubeconfig for AWS EKS cluster
echo "Updating kubeconfig for EKS cluster..."
aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER_NAME"
if [ $? -ne 0 ]; then
  echo "Failed to update kubeconfig. Exiting."
  exit 1
fi

# Create Argo CD namespace
echo "Creating namespace $NAMESPACE..."
kubectl create namespace "$NAMESPACE"
if [ $? -ne 0 ]; then
  echo "Failed to create namespace. Exiting."
  exit 1
fi

# Apply Argo CD manifest
echo "Applying Argo CD manifest..."
kubectl apply -n "$NAMESPACE" -f "$ARGOCD_MANIFEST"
if [ $? -ne 0 ]; then
  echo "Failed to apply Argo CD manifest. Exiting."
  exit 1
fi

echo "Argo CD installation completed successfully."
