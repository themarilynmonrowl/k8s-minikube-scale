# Kubernetes Demo — Scale an App on Minikube (2 Nodes)

This repo shows how to start a **two-node Minikube cluster**, deploy a demo app, **scale it up**, and inspect pods with `kubectl -o wide`.

## Prerequisites
- **Minikube** and **kubectl** installed.
- Docker/HyperKit/Hyper-V/etc. driver configured for Minikube.
- Enough CPU/RAM to run 2 nodes.

> If Minikube fails to start with two nodes, **reboot your machine** and try again.

---

## 1) Start a fresh two-node Minikube cluster

```bash
# Remove any previous clusters/images/containers (optional but recommended)
minikube delete

# Start Minikube with two nodes
minikube start --nodes 2

# Verify nodes
kubectl get nodes
```

You should see two `Ready` worker nodes (e.g., `minikube` and `minikube-m02`).

---

## 2) Deploy the demo app

Apply the manifests (Deployment + Service):

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Check pods and their node placement:

```bash
kubectl get pods -o wide
```

> The Deployment starts with **2 replicas** of `nginx:alpine`.

---

## 3) Scale the app

Increase replicas to 5 (or any number):

```bash
kubectl scale deployment demo-app --replicas=5
kubectl get pods -o wide
```

> You should now see 5 pods, scheduled across your two Minikube nodes.

---

## 4) Access the Service

The Service is a **NodePort** on port 80 -> container port 80.

```bash
# Get the service details
kubectl get svc demo-app

# If you want a quick URL in Minikube
minikube service demo-app --url
```

Open the printed URL in your browser to see the NGINX welcome page.

---

## 5) Cleanup

```bash
kubectl delete -f k8s/service.yaml
kubectl delete -f k8s/deployment.yaml
minikube delete
```

---

## Files

- `k8s/deployment.yaml` — **Deployment** with 2 replicas (nginx:alpine), resource requests/limits, labels.
- `k8s/service.yaml` — **NodePort Service** exposing the Deployment on port 80.
- `scripts/start_minikube_2nodes.sh` — Start a fresh 2-node cluster.
- `scripts/deploy.sh` — Apply manifests.
- `scripts/scale.sh` — Scale to a desired replica count.
- `scripts/status.sh` — Nodes and pods overview.
- `scripts/cleanup.sh` — Delete resources and the cluster.

---

## Bonus (Optional): Horizontal Pod Autoscaler (HPA)

If you want, add an HPA later:

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: demo-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: demo-app
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 60
```

Make sure your cluster has metrics (e.g., `minikube addons enable metrics-server`).
