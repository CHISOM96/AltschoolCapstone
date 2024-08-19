resource "aws_eks_node_group" "shop_node_group" {
  cluster_name    = aws_eks_cluster.shop_eks.name
  node_group_name = "shop-node-group"
  node_role_arn   = aws_iam_role.shop_node_role.arn
  subnet_ids      = aws_subnet.shop_subnets[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

resource "aws_iam_role" "shop_node_role" {
  name = "shop-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "shop_node_policy" {
  role       = aws_iam_role.shop_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
