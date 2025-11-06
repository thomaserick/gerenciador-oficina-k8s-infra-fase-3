resource "aws_eks_access_entry" "access_entry" {
  cluster_name      = var.cluster_name
  principal_arn     = data.aws_iam_user.principal_user.arn
  kubernetes_groups = ["group-soat", "group-admin"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "access_entry_association" {
  cluster_name  = var.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = data.aws_iam_user.principal_user.arn

  access_scope {
    type = "cluster"
  }
}
