variable "project_name" { default = "gerenciador-oficina-core" }
variable "aws_region" { default = "us-east-1" }
variable "bucket_name" { default = "gerenciador-oficina-fiap" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "instance_type" { default = "t3.small" }
variable "user_name" { default = "fiap-oficina" }
variable "cluster_role_name" {
  description = "Nome do IAM Role para o cluster do EKS"
  default     = "eks-cluster-role"
}
variable "node_role_name" {
  description = "Nome do IAM Role para o node group do EKS"
  default     = "eks-node-role"
}


