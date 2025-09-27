#!/usr/bin/env bash
set -euo pipefail
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods -o wide
kubectl get svc demo-app
