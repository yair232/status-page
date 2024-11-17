<div align="center">
    <img alt="Status Page" src="https://cdn.herrtxbias.net/status-page/logo_gray/logo_small.png"></a>
</div>
<br />
<p align="center">
    <a href="https://github.com/Status-Page/Status-Page"><img alt="GitHub license" src="https://img.shields.io/github/license/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/network"><img alt="GitHub forks" src="https://img.shields.io/github/forks/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/Status-Page/Status-Page"></a>
    <a href="https://github.com/Status-Page/Status-Page/releases"><img alt="GitHub latest releas" src="https://img.shields.io/github/release/Status-Page/Status-Page"></a>
    <a href="https://www.codacy.com/gh/Status-Page/Status-Page/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Status-Page/Status-Page&amp;utm_campaign=Badge_Grade"><img src="https://app.codacy.com/project/badge/Grade/250b53ad99ca432cbac8d761a975b34d"/></a>
</p>

# High Availability and Scalability Infrastructure

## Overview
This repository contains the implementation of a **highly available and scalable infrastructure** for a Django-based web application. The project is modular, leveraging industry-standard tools such as **ArgoCD**, **Terraform**, **Kubernetes**, and **Jenkins CI/CD pipelines**. Each module ensures optimal reliability, performance, and ease of scaling in both local and production environments.

For detailed instructions on specific components, refer to the respective READMEs linked below.

---

## Key Features
- **High Availability**:  
  Ensures redundancy and failover mechanisms across all critical services. Workloads are distributed using Kubernetes to handle potential failures seamlessly.
  
- **Scalability**:  
  The infrastructure supports both horizontal and vertical scaling for services, databases, and application layers. Kubernetes auto-scaling is configured to handle varying traffic loads dynamically.
  
- **Infrastructure as Code (IaC)**:  
  Utilizes Terraform for provisioning cloud resources consistently and reproducibly, across development, staging, and production environments.
  
- **CI/CD Integration**:  
  Jenkins pipelines automate the build, test, and deployment processes. ArgoCD handles GitOps workflows, ensuring consistency between Git configurations and deployed states.

---

## Repository Structure
- **[ArgoCD](./argo-app-manager/README.md)**  
  Manages GitOps workflows to maintain infrastructure and application state consistency.

- **[Jenkins CI/CD](./contrib/jenkins/README.md)**  
  Automates the pipeline for building, testing, and deploying the Django application.

- **[Terraform](./final-project-terraform/README.md)**  
  Handles provisioning of cloud infrastructure, such as Kubernetes clusters and associated resources.

- **[Kubernetes](./k8s/README.md)**  
  Orchestrates containerized services to achieve high availability, auto-scaling, and load balancing.

- **[Architecture Flowchart](./Architecture%20-%20FlowChart/README.md)**  
  Illustrates the overall system architecture, showcasing how components interact to provide scalability and resilience.

---

## Getting Started
1. **Clone the Repository**:  
   ```bash
   git clone https://github.com/yair232/status-page.git
   cd status-page
