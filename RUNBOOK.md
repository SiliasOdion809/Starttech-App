# RUNBOOK.md

# StartTech Operations Runbook

## Overview

This runbook provides operational procedures, troubleshooting steps, deployment instructions, monitoring guidance, and recovery procedures for the StartTech full-stack production environment.

The platform consists of:

- React frontend hosted on Amazon S3 with CloudFront CDN
- Golang backend deployed on EC2 instances
- Dockerized backend containers
- MongoDB Atlas database
- Redis ElastiCache cluster
- CI/CD pipelines using GitHub Actions
- Monitoring using Amazon CloudWatch

---

# Table of Contents

1. Backend Operations
2. Frontend Operations
3. Deployment Procedures
4. Health Check Procedures
5. Rollback Procedures
6. Docker Troubleshooting
7. EC2 Troubleshooting
8. CloudWatch Monitoring
9. Common Issues and Solutions
10. Emergency Recovery Procedures

---

# Backend Operations

## Check Running Containers

```bash
docker ps
```

---

## View Backend Logs

```bash
docker logs backend
```

---

## Restart Backend Container

```bash
docker restart backend
```

---

## Stop Backend Container

```bash
docker stop backend
```

---

## Remove Backend Container

```bash
docker rm backend
```

---

## Access Backend Container Shell

```bash
docker exec -it backend sh
```

---

# Frontend Operations

## Verify Frontend Deployment

Open the CloudFront URL in a browser:

```text
https://<cloudfront-distribution-domain>
```

---

## Verify S3 Static Website

```bash
aws s3 ls
```

---

## Invalidate CloudFront Cache

```bash
aws cloudfront create-invalidation \
--distribution-id <distribution-id> \
--paths "/*"
```

---

# Deployment Procedures

# Backend Deployment

## Manual Backend Deployment

```bash
bash scripts/deploy-backend.sh
```

---

## Verify Backend Deployment

```bash
docker ps
```

---

## Verify Backend Health Endpoint

```bash
curl http://localhost:8080/health
```

Expected response:

```json
{
  "cache":"disabled",
  "database":"ok"
}
```

---

# Frontend Deployment

## Manual Frontend Deployment

```bash
bash scripts/deploy-frontend.sh
```

---

# Health Check Procedures

## Backend Health Endpoint

```bash
curl http://localhost:8080/health
```

Expected HTTP response:

```text
200 OK
```

---

## Load Balancer Health Checks

AWS Console:

```text
EC2 → Target Groups → Health Checks
```

Verify:
- healthy targets
- successful responses
- no failing instances

---

# Rollback Procedures

## Rollback Backend Deployment

```bash
bash scripts/rollback.sh <image-tag>
```

Example:

```bash
bash scripts/rollback.sh 561876735341.dkr.ecr.eu-west-1.amazonaws.com/starttech-backend:previous
```

---

# Docker Troubleshooting

## Check Docker Service Status

```bash
sudo systemctl status docker
```

---

## Restart Docker Service

```bash
sudo systemctl restart docker
```

---

## Remove Unused Docker Resources

```bash
docker system prune -a
```

---

## Check Docker Images

```bash
docker images
```

---

## Pull Latest Backend Image

```bash
docker pull 561876735341.dkr.ecr.eu-west-1.amazonaws.com/starttech-backend:latest
```

---

# Amazon ECR Operations

## Login to Amazon ECR

```bash
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 561876735341.dkr.ecr.eu-west-1.amazonaws.com
```

---

## Verify ECR Images

```bash
aws ecr describe-images \
--repository-name starttech-backend \
--region eu-west-1
```

---

# EC2 Troubleshooting

## SSH Into EC2 Instance

```bash
ssh -i starttech-key.pem ubuntu@<ec2-public-ip>
```

---

## Check Disk Usage

```bash
df -h
```

---

## Check Running Processes

```bash
htop
```

---

## Check Memory Usage

```bash
free -m
```

---

## Check Open Ports

```bash
sudo netstat -tulpn
```

---

## Check Application Port

```bash
sudo lsof -i :8080
```

---

# CloudWatch Monitoring

## Verify CloudWatch Agent Status

```bash
sudo systemctl status amazon-cloudwatch-agent
```

---

## Restart CloudWatch Agent

```bash
sudo systemctl restart amazon-cloudwatch-agent
```

---

## Verify CloudWatch Logs

AWS Console:

```text
CloudWatch → Log Groups → /starttech/backend
```

Verify:
- backend logs
- Docker logs
- EC2 logs
- application logs

---

# MongoDB Atlas Operations

## Verify MongoDB Connectivity

```bash
curl http://localhost:8080/health
```

Expected:

```json
{
  "database":"ok"
}
```

---

# Redis Operations

## Verify Redis Connectivity

```bash
redis-cli ping
```

Expected:

```text
PONG
```

---

# Common Issues and Solutions

# Issue: Container Fails to Start

## Possible Causes

- Invalid environment variables
- Port conflicts
- MongoDB connection failure
- Missing Docker image

## Solution

Check logs:

```bash
docker logs backend
```

Verify:
- MongoDB URI
- Redis configuration
- environment variables
- container ports

---

# Issue: Docker Login Failure

## Possible Causes

- Expired ECR token
- Incorrect AWS credentials
- IAM permission issues

## Solution

Re-authenticate:

```bash
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 561876735341.dkr.ecr.eu-west-1.amazonaws.com
```

---

# Issue: Health Check Failure

## Solution

Check backend health:

```bash
curl http://localhost:8080/health
```

Inspect logs:

```bash
docker logs backend
```

Verify:
- application startup
- MongoDB connectivity
- Redis connectivity

---

# Issue: GitHub Actions Deployment Failure

## Solution

Check:
- GitHub Secrets
- AWS credentials
- SSH key configuration
- ECR repository permissions

View workflow logs:

```text
GitHub → Actions → Workflow Logs
```

---

# Monitoring Checklist

Daily operational checks:

- Verify backend containers are running
- Verify ALB health checks pass
- Verify CloudWatch logs are updating
- Verify MongoDB connectivity
- Verify Redis availability
- Verify frontend accessibility
- Verify ECR image pushes succeed

---

# Emergency Recovery Procedures

## Backend Recovery Steps

1. SSH into EC2 instance
2. Verify Docker service
3. Restart backend container
4. Pull latest Docker image
5. Run rollback script if deployment failed
6. Verify health endpoint
7. Monitor CloudWatch logs

---

# Security Best Practices

- Rotate IAM credentials regularly
- Use GitHub Secrets for sensitive values
- Restrict Security Group access
- Use least-privilege IAM policies
- Avoid hardcoding secrets in repositories
- Regularly scan Docker images for vulnerabilities

---

# Operational Best Practices

- Always verify health checks after deployment
- Monitor CloudWatch logs regularly
- Use rolling deployments
- Keep Docker images updated
- Maintain proper backup procedures
- Document infrastructure changes

---

# Author

Silias Odion

Cloud / DevOps Engineering Project