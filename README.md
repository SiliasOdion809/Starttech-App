# README.md

# StartTech Full Stack DevOps Project

## Project Overview

This project implements a complete production-style CI/CD pipeline for the StartTech full-stack application using AWS cloud services, Docker, GitHub Actions, Terraform, MongoDB Atlas, and DevOps best practices.

The platform consists of:

- Frontend React application deployed to Amazon S3 with CloudFront CDN
- Backend Golang API deployed on EC2 instances behind an Application Load Balancer
- Dockerized backend deployment using Amazon ECR
- MongoDB Atlas for persistent database storage
- Redis ElastiCache for caching and session management
- CI/CD pipelines implemented using GitHub Actions
- Infrastructure provisioning using Terraform
- Monitoring and observability using Amazon CloudWatch

---

# Technologies Used

## Frontend

- React
- Node.js
- npm
- Amazon S3
- CloudFront CDN

---

## Backend

- Golang
- Docker
- MongoDB Atlas
- Redis
- Amazon EC2
- Application Load Balancer
- Auto Scaling Group

---

## DevOps & Infrastructure

- GitHub Actions
- Terraform
- Amazon ECR
- CloudWatch
- IAM Roles & Policies
- Security Groups

---

# Project Architecture

```text
Users
   ↓
CloudFront CDN
   ↓
S3 Static Website Hosting
   ↓
Frontend React Application
   ↓
Application Load Balancer
   ↓
EC2 Auto Scaling Group
   ↓
Dockerized Golang Backend
   ↓
MongoDB Atlas
   ↓
Redis ElastiCache
```

---

# Repository Structure

```text
starttech-application/
├── .github/
│   └── workflows/
│       ├── frontend-ci-cd.yml
│       └── backend-ci-cd.yml
│
├── frontend/
│
├── backend/
│   └── MuchToDo/
│
├── scripts/
│   ├── deploy-frontend.sh
│   ├── deploy-backend.sh
│   ├── health-check.sh
│   └── rollback.sh
│
├── README.md
├── ARCHITECTURE.md
└── RUNBOOK.md
```

---

# CI/CD Pipeline Overview

## Frontend Pipeline

The frontend pipeline performs:

1. Dependency installation
2. React application build
3. Unit testing
4. npm audit security scanning
5. Deployment to Amazon S3
6. CloudFront cache invalidation

---

## Backend Pipeline

The backend pipeline performs:

1. Docker image build
2. Vulnerability scanning
3. Push image to Amazon ECR
4. SSH deployment to EC2 servers
5. Rolling container replacement
6. Health endpoint verification
7. CloudWatch log integration

---

# Environment Variables

## Backend Environment Variables

```env
PORT=8080
MONGO_URI=<mongodb-atlas-uri>
DB_NAME=much_todo_db
JWT_SECRET_KEY=<jwt-secret>
REDIS_HOST=<redis-endpoint>
REDIS_PORT=6379
```

---

# Deployment Process

## Frontend Deployment

```bash
bash scripts/deploy-frontend.sh
```

---

## Backend Deployment

```bash
bash scripts/deploy-backend.sh
```

---

# Health Checks

Backend health endpoint:

```text
/health
```

Example:

```bash
curl http://localhost:8080/health
```

Expected Response:

```json
{
  "cache":"disabled",
  "database":"ok"
}
```

---

# Monitoring

Monitoring is implemented using:

- Amazon CloudWatch Logs
- CloudWatch Log Groups
- Docker container logs
- Application health checks

---

# Security Implementation

Security practices implemented:

- IAM least-privilege access
- GitHub Secrets management
- Docker image vulnerability scanning
- Private Amazon ECR repositories
- Security Groups for network access control
- MongoDB Atlas authentication
- SSH key-based EC2 access

---

# Setup Instructions

## Clone Repository

```bash
git clone <repository-url>
```

---

## Install Frontend Dependencies

```bash
cd frontend
npm install
```

---

## Run Frontend Locally

```bash
npm start
```

---

## Run Backend Locally

```bash
cd backend/MuchToDo
go mod tidy
go run ./cmd/api
```

---

# Docker Commands

## Build Backend Image

```bash
docker build -t starttech-backend .
```

## Run Backend Container

```bash
docker run -d -p 8080:8080 starttech-backend
```

---

# Future Improvements

- HTTPS with Let's Encrypt
- Blue/Green Deployments
- ECS or Kubernetes Migration
- Prometheus & Grafana Monitoring
- Automated Rollbacks
- Zero-Downtime Deployments

---

# Author

Silias Odion

Cloud / DevOps Engineering Project