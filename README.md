🚀 DevOps Automation of a 3-Tier WordPress Application (Local Kubernetes)
📌 Project Objective

This project demonstrates the complete DevOps lifecycle for deploying and monitoring a 3-tier WordPress application, using:

Docker (containerization)

Docker Compose (local multi-container validation)

Kubernetes (orchestration via Minikube)

GitHub Actions (CI/CD automation)

Prometheus & Grafana (monitoring and alerting)

All components are implemented locally using open-source tools, focusing on DevOps engineering practices rather than application development.

🧾 Application Source Code

The WordPress application source code was cloned from the official open-source repository:

🔗 https://github.com/WordPress/WordPress

git clone https://github.com/WordPress/WordPress.git app

The app/ directory in this project contains the cloned WordPress source code.

Note: The application code was not developed from scratch. This project focuses strictly on DevOps implementation and automation.

🏗️ 3-Tier Architecture Design

This project follows a logical 3-tier architecture:

1️⃣ Presentation Tier

Apache Web Server

Handles HTTP requests

Serves WordPress frontend

Exposed via Kubernetes NodePort Service

2️⃣ Application Tier

PHP runtime executing WordPress core logic

Handles:

Authentication

Admin operations

Business logic

Plugin execution

Deployed as Kubernetes Deployment

3️⃣ Data Tier

MySQL database

Deployed as Kubernetes StatefulSet

PersistentVolumeClaim (PVC) for storage

Headless Service for stable networking

🧰 Tech Stack
Layer	Tool	Purpose
Containerization	Docker	Build custom WordPress image
Local Validation	Docker Compose	Multi-container environment testing
Orchestration	Kubernetes (Minikube)	Manage deployments, services, storage
CI/CD	GitHub Actions	Automated build and validation
Monitoring	Prometheus	Metrics collection
Visualization	Grafana	Dashboard & observability
Packaging	Helm	Install monitoring stack
🖥️ Prerequisites (Local Setup)

Before running this project locally, install:

1️⃣ Docker

Used for building images

Required by Minikube (Docker driver)

docker --version
2️⃣ Minikube

Local Kubernetes cluster

minikube version
3️⃣ kubectl

Kubernetes CLI

kubectl version --client
4️⃣ Helm

Used to install Prometheus & Grafana

helm version
🐳 Step 1: Containerization (Docker)

A custom WordPress image is built using:

Base image: php:8.2-apache

Required PHP extensions installed

WordPress source copied from app/

Example build command:

docker build -t custom-wordpress:1.0 ./docker/wordpress

This image contains:

Apache web server

PHP runtime

WordPress source code

🧪 Step 2: Local Multi-Container Testing (Docker Compose)

Before Kubernetes deployment, Docker Compose is used to validate:

WordPress ↔ MySQL connectivity

Environment variables

Database initialization

Network communication

Run:

docker compose up -d

This creates:

WordPress container

MySQL container

Docker network

Persistent volumes

Purpose:

Validate container-level configuration before orchestration.

☸️ Step 3: Kubernetes Deployment (Minikube)
Start Minikube
minikube start
Apply Kubernetes Manifests
kubectl apply -f k8s/

This deploys:

Namespace

wordpress

MySQL

StatefulSet

Headless Service

PVC

WordPress

Deployment

Service (NodePort)

Access WordPress
minikube service wordpress -n wordpress
What Kubernetes Handles

Pod scheduling

Self-healing

Restart on failure

Service discovery

Persistent storage

Rolling updates

🔁 CI/CD Pipeline (GitHub Actions)

Located in:

.github/workflows/ci-cd.yaml
Continuous Integration (CI)

On push to main:

Checkout repository

Build Docker image

Validate Kubernetes manifests

Ensure configuration consistency

Continuous Delivery (CD)

Spin up ephemeral Minikube cluster

Deploy application

Wait for rollout success

Perform smoke validation

Deployment remains local (Continuous Delivery, not Deployment).

📊 Monitoring & Observability

Monitoring stack installed using Helm:

helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring
Prometheus

Collects:

Node metrics

Pod metrics

Container CPU & memory

Namespace-level metrics

Grafana

Access via:

kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80

Dashboards include:

Kubernetes cluster health

Pod resource usage

Namespace metrics

Alerting

Custom PrometheusRule implemented:

WordPress pod restart alert

High CPU usage alert

Alertmanager evaluates and manages alerts.

🔍 How Everything Works Together
1️⃣ Developer Pushes Code

⬇
GitHub Actions builds Docker image
⬇
Kubernetes manifests validated
⬇
Application deployed in Minikube
⬇
Prometheus scrapes metrics
⬇
Grafana visualizes dashboards
⬇
Alerts triggered if thresholds exceeded

📂 Final Project Structure
3-tier-web/
├── app/                      # Cloned WordPress source
├── docker/wordpress/         # Dockerfile
├── docker-compose.yml        # Local container validation
├── k8s/
│   ├── namespace.yaml
│   ├── mysql/
│   ├── wordpress/
│   └── monitoring/
├── .github/workflows/        # CI/CD pipeline
└── README.md
🔐 DevOps Concepts Demonstrated

3-tier architecture design

Container lifecycle management

Kubernetes workload orchestration

Stateful workloads with PVC

CI/CD automation

Infrastructure as Code

Observability and alerting

Namespace isolation

Rolling deployments

Self-healing systems

🚫 Out of Scope

Cloud deployment

Infrastructure provisioning

External alert integrations

WordPress plugin development
