#!/usr/bin/env bash
set -euo pipefail
echo "[*] Deleting any previous Minikube cluster..."
minikube delete || true
echo "[*] Starting Minikube with 2 nodes..."
minikube start --nodes 2
echo "[*] Nodes:"
kubectl get nodes -o wide
