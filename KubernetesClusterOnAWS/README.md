# Kubernetes Cluster Setup on AWS using Terraform

This project demonstrates how to create a Kubernetes cluster using AWS Elastic Kubernetes Service (EKS) with Terraform. It is organized into reusable modules for VPC, EKS, and Node Groups.

## Features
- Creates an AWS VPC with public and private subnets.
- Deploys an EKS cluster with appropriate IAM roles and policies.
- Configures Node Groups for worker nodes.
- Outputs essential information like cluster name, endpoint, and kubeconfig file.