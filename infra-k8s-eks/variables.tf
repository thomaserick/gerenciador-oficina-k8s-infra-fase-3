variable "project_name" { default = "gerenciador-oficina-core" }
variable "aws_region" { default = "us-east-1" }
variable "bucket_name" { default = "gerenciador-oficina-fiap" }
variable "eks_auto_mode" {
  description = "Habilita o modo EKS Auto (gerenciado totalmente pela AWS)"
  type        = bool
  default     = true
}

## VPC Envs ##
variable "vpc_cidr" { default = "10.0.0.0/16" }
