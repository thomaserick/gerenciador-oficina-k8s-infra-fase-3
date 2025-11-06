# IAM Role para os nós (Node Group)
resource "aws_iam_role" "node_role" {
  name = var.node_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Políticas necessárias para os nós
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  policy_arn = each.value
  role       = aws_iam_role.node_role.name
}

# EKS Node Group
resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "nodeg-${var.cluster_name}"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids
  disk_size       = 20
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  #Sempre disponivel 1 node no update
  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = "nodeg-${var.cluster_name}"
  }

  depends_on = [aws_iam_role_policy_attachment.eks_node_policy]

}

# Enable Metrics Server Addon for EKS Cluster
resource "aws_eks_addon" "metrics_server" {
  cluster_name = var.cluster_name
  addon_name   = "metrics-server"

  depends_on = [aws_eks_node_group.node_group]
}

