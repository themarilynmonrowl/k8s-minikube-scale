#!/usr/bin/env bash
set -euo pipefail
REPLICAS=${1:-5}
echo "[*] Scaling demo-app to ${REPLICAS} replicas..."
kubectl scale deployment demo-app --replicas="${REPLICAS}"
kubectl rollout status deployment/demo-app
kubectl get pods -o wide
