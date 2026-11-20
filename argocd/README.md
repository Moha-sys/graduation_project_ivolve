# Continuous Deployment with Argo CD (GitOps)

This directory configures automated GitOps continuous deployment using **Argo CD**.

## Overview
When the Jenkins CI pipeline pushes updated container image tags into the Kubernetes manifests in `k8s/`, Argo CD detects the git commit on the `main` branch, evaluates the diff against the live Kubernetes cluster state, and automatically synchronizes the microservices with zero manual intervention.

## GitOps Configuration
- **Application Manifest (`application.yaml`)**:
  - Target Repo: `https://github.com/Moha-sys/graduation_project_ivolve.git`
  - Target Path: `k8s` (recursive)
  - Target Namespace: `ivolve`
  - Sync Policy: `automated` with `prune: true` and `selfHeal: true`
  - Sync Options: `CreateNamespace=true`

## Quick Setup

```bash
chmod +x argocd/setup-argocd.sh
./argocd/setup-argocd.sh
```

## Accessing Argo CD UI

1. Expose the ArgoCD server:
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8081:443
   ```
2. Retrieve the admin password:
   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```
3. Open `https://localhost:8081` in your browser.
