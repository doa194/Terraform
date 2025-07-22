# Create the EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name // Name of the EKS 
  role_arn = aws_iam_role.eks_cluster_role.arn // IAM role for the EKS cluster
  

  vpc_config {
    subnet_ids = var.subnet_ids // Specify the private subnet IDs
  }

  kubernetes_network_config {
    service_ipv4_cidr = "10.100.0.0/16" // Specify the service CIDR block
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"] // Enable logging for the cluster

  version = var.kubernetes_version // Specify the Kubernetes version
}