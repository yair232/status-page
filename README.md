<div align="center">
    <img alt="Status Page" src="https://cdn.herrtxbias.net/status-page/logo_gray/logo_small.png"></a>
</div>
<br />
<p align="center">
    <a href="https://github.com/Status-Page/Status-Page"><img alt="GitHub license" src="https://img.shields.io/github/license/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/network"><img alt="GitHub forks" src="https://img.shields.io/github/forks/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/releases"><img alt="GitHub latest release" src="https://img.shields.io/github/release/Status-Page/Status-Page"></a>
    <a href="https://www.codacy.com/gh/Status-Page/Status-Page/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Status-Page/Status-Page&amp;utm_campaign=Badge_Grade"><img src="https://app.codacy.com/project/badge/Grade/250b53ad99ca432cbac8d761a975b34d"/></a>
</p>

# High Availability and Scalability Infrastructure

![Alt text](./Architecture%20-%20FlowChart/Application%20Architecture.png)

## Overview

This repository contains the implementation of a **highly available, scalable, and production-grade infrastructure** for a Django-based web application. The architecture integrates **Jenkins for CI**, **Terraform for infrastructure provisioning**, and **ArgoCD for continuous delivery**, ensuring efficient deployments, robust scalability, and streamlined workflows.

### Key Features

1. **CI/CD Workflow:**

   - **Continuous Integration (CI):**
     - Jenkins automates the CI pipeline, building, testing, and validating application changes.
     - Terraform scripts are triggered by Jenkins to provision cloud infrastructure, such as AWS EKS clusters, load balancers, and RDS databases.
   - **Continuous Delivery (CD):**
     - ArgoCD ensures Kubernetes manifests are deployed and synced to the cluster, maintaining the desired application state.

2. **Infrastructure as Code (IaC):**

   - **Terraform** provisions all critical AWS resources, including:
     - Amazon EKS for container orchestration.
     - Elastic Load Balancers (ELB) for traffic management.
     - RDS PostgreSQL for a reliable and scalable database.
     - Redis for high-performance caching.
   - Modular and reusable Terraform scripts enable easy updates and scaling.

3. **High Availability and Fault Tolerance:**

   - Horizontal Pod Autoscaler (HPA) dynamically adjusts application pods based on resource usage.
   - Amazon EKS nodes use autoscaling groups to ensure infrastructure scales to meet demand.
   - RDS Multi-AZ deployment provides database redundancy and fault tolerance.

4. **Scalability:**

   - Kubernetes ensures horizontal scaling of application pods and infrastructure nodes.
   - Cost efficiency is achieved through autoscaling mechanisms that respond to traffic patterns.

5. **Centralized Logging and Monitoring:**

   - **Fluent Bit** aggregates application logs and forwards them to the Elastic Stack (Elasticsearch and Kibana).
   - **Prometheus and Grafana** provide robust monitoring and alerting:
     - Preconfigured Grafana dashboards visualize resource utilization, request latencies, and alerts.
     - Prometheus monitors infrastructure and application performance metrics.

6. **GitOps with ArgoCD:**

   - ArgoCD leverages **ApplicationSet** to streamline and automate the deployment of multiple applications in the Kubernetes cluster.
   - GitOps practices ensure that all application and infrastructure changes are version-controlled.

7. **Automated Workflow:**

   - Developers push code to GitHub.
   - Jenkins CI pipelines:
     - Build and test Docker images.
     - Trigger Terraform scripts for infrastructure updates.
   - ArgoCD syncs Kubernetes manifests for deployment.

8. **Database Setup:**
   - A highly available **RDS PostgreSQL** instance stores application data with Multi-AZ replication.
   - **Redis** acts as a caching layer to optimize database performance and reduce latency.

---

## Getting Started

To deploy and operate the infrastructure, follow these steps:

### Step 1: Initialize Terraform for Jenkins EC2

Enter [terraform](Terraform/README.md) and follow the instructions.

---

### Step 2: Restore the Jenkins Backup

Enter [terraform/jenkins](Terraform/Jenkins) and follow the instructions.

---

### Step 3: Set Up ArgoCD

#### Navigate to **ArgoCD Directories**:

1. **Argo App Manager**:
   - Contains YAML manifests for deploying Kubernetes resources.
2. **Argo Start**:
   - Key file: `my-app-of-apps.yaml`.

#### Deploy ArgoCD Applications:

1. Apply the **`my-app-of-apps.yaml`** configuration:
   ```bash
   kubectl apply -f argocd-start/my-app-of-apps.yaml
   ```
