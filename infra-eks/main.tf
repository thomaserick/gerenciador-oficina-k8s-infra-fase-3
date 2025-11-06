## S3 Config ##
# module "s3" {
#   source      = "./modules/s3"
#   bucket_name = var.bucket_name
# }


## VPC Config ##
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.project_name
}

## EKS Config ##
module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.project_name
  subnet_ids        = module.vpc.public_subnet_ids
  cluster_role_name = var.cluster_role_name

  depends_on = [module.vpc]
}

## EKS Access Entry Config ##
module "eks-access-entry" {
  source       = "./modules/eks-access-entry"
  cluster_name = var.project_name
  user_name    = var.user_name
  depends_on   = [module.eks]
}

## EKS node Config ##
module "eks-node" {
  source         = "./modules/eks-node"
  cluster_name   = var.project_name
  subnet_ids     = module.vpc.public_subnet_ids
  node_role_name = var.node_role_name
  instance_type  = var.instance_type

  depends_on = [module.eks]
}


