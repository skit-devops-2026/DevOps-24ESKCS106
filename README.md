# Digital Bank

## Author

| Roll No. | Name | GitHub username |
|---|---|---|
| 24ESKCS106 | Devang Bisartii | bisartii |

## About
At Digital Bank, we are redefining how individuals and modern enterprises interact with their finances. Born out of a vision to bridge the gap between complex financial infrastructure and everyday usability, our platform delivers a seamless, secure, and intuitive digital banking experience right to your screen.

## Tech Stack

- **Frontend**: HTML5, CSS3, Modern JavaScript (Vanilla JS)
- **Web Server / Reverse Proxy**: Nginx (Alpine Linux)
- **Containerization**: Docker, Docker Compose
- **Metrics & Monitoring**: Nginx Prometheus Exporter, Prometheus, Grafana
- **Orchestration**: Kubernetes (Deployment, Service)

## Running Locally

### 1. Direct Static Run
```bash
make install
make run
```

### 2. Docker Build & Run (M5)
```bash
# Build the Docker image with current Git commit SHA embedded
make docker-build

# Or build manually:
docker build --build-arg COMMIT_SHA=$(git rev-parse --short HEAD 2>/dev/null || echo "latest") -t devops-digital-bank:latest -t bisartii/digital-bank:latest .

# Run the container
docker run -d --name digital-bank-web -p 8080:80 devops-digital-bank:latest
```

### 3. Docker Compose Stack with Monitoring (M5 & M6)
```bash
# Start web application, Prometheus, Nginx Exporter, and Grafana
make docker-up

# Check container status
docker compose ps

# View service logs
docker compose logs -f
```

## Live URL

- **Production Live URL**: https://digital-bank-dmfu.onrender.com
- **Production Health Endpoint**: https://digital-bank-dmfu.onrender.com/health
- **Local Deployment URL**: http://localhost:8080
- **Local Health Endpoint**: http://localhost:8080/health

## Health Endpoint

`GET /health` returns the exact running Git commit SHA (e.g. `135a04a`) with `Content-Type: text/plain` and cache-prevention headers.

```bash
curl -i http://localhost:8080/health
```

## Container Registry

- **Repository**: `devangbisartii/digital-bank`
- **Tags**: `latest`, `<git-commit-sha>`

### Publishing to Docker Hub
```bash
# Authenticate to Docker Hub
docker login -u devangbisartii

# Push the verified image
docker push devangbisartii/digital-bank:latest
```

## Monitoring Stack (M6)

The monitoring architecture collects and visualizes real web server metrics without requiring third-party cloud services:

- **Nginx Stub Status**: Internal endpoint enabled in `nginx.conf` at `/stub_status`.
- **Nginx Prometheus Exporter**: Runs on port `9113` and scrapes `/stub_status` to expose standard Prometheus metrics (`nginx_up`, `nginx_http_requests_total`, `nginx_connections_active`, etc.).
- **Prometheus**: Accessible at [http://localhost:9090](http://localhost:9090). Scrapes Prometheus and Nginx targets every 10 seconds.
- **Grafana**: Accessible at [http://localhost:3000](http://localhost:3000) (Default user: `admin` / `admin`).
  - Pre-provisioned Prometheus data source.
  - Pre-provisioned "Digital Bank Nginx & Traffic Dashboard" (`monitoring/dashboard.json`).

## Kubernetes Deployment (M7)

Kubernetes manifests are located in `k8s/`:
- `k8s/deployment.yaml`: Replicas, resource limits/requests, liveness/readiness probes on `/health`.
- `k8s/service.yaml`: NodePort service exposing port 80 on NodePort 30080.

### Deploying to Local Cluster (Kind)
```bash
# Create cluster (if not already running)
kind create cluster --name digital-bank-cluster

# Load image into cluster nodes
kind load docker-image devangbisartii/digital-bank:latest --name digital-bank-cluster

# Apply manifests
kubectl apply -f k8s/

# Verify Pods and Services
kubectl get deployments,pods,services
kubectl get pods -o wide

# Port-forward for access
kubectl port-forward service/digital-bank-service 8888:80
```

## Stopping & Teardown

```bash
# Stop Docker Compose stack
docker compose down

# Delete Kind Kubernetes cluster
kind delete cluster --name digital-bank-cluster
```
