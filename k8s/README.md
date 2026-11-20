# Kubernetes Container Orchestration Manifests

This directory contains the production-grade Kubernetes manifests for deploying the entire iVolve microservices architecture to the EKS cluster.

## Resources Overview

1. **Namespace (`namespace.yaml`)**:
   - `ivolve` namespace to isolate application workloads.
2. **StorageClass (`storageclass.yaml`)**:
   - `ivolve-storage-class` for persistent volume binding and lifecycle management.
3. **Configuration & Secrets (`configmap.yaml`, `secret.yaml`)**:
   - `ivolve-config`: Service endpoints and DB host/port parameters.
   - `ivolve-secret`: Database credentials and web session secrets.
4. **Database StatefulSet & Headless Service (`database/`)**:
   - `mysql-statefulset.yaml`: MySQL 8.0 with automated volume claims (`mysql-data`, 5Gi), health probes.
   - `mysql-service.yaml`: Headless service (`clusterIP: None`) for stable network hostname (`mysql-service`).
5. **Backend Microservices (`auth-service/`, `roadmap-service/`)**:
   - `auth-service`: 2 replicas, `wait-for-mysql` initContainer, health probes, ClusterIP service on port 5000.
   - `roadmap-service`: 2 replicas, health probes, ClusterIP service on port 8080.
6. **Frontend Microservice (`frontend/`)**:
   - `frontend`: 2 replicas, ClusterIP service on port 3000.
7. **Ingress (`ingress.yaml`)**:
   - NGINX Ingress controller resource exposing the frontend externally at `/`.

## Manual Deployment Order

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/storageclass.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/database/
kubectl apply -f k8s/auth-service/
kubectl apply -f k8s/roadmap-service/
kubectl apply -f k8s/frontend/
kubectl apply -f k8s/ingress.yaml
```
