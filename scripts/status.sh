#!/usr/bin/env bash
set -euo pipefail
echo "[*] Nodes:"
kubectl get nodes -o wide
echo
echo "[*] Pods:"
kubectl get pods -o wide
echo
echo "[*] Services:"
kubectl get svc
