#!/usr/bin/env bash
set -euo pipefail
kubectl delete -f k8s/service.yaml || true
kubectl delete -f k8s/deployment.yaml || true
minikube delete || true
