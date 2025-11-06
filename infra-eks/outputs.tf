output "cluster_name" {
  value = var.project_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}
