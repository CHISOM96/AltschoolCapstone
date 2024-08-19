resource "aws_eks_cluster" "shop_eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.shop_eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.shop_subnets[*].id
  }

  depends_on = [aws_iam_role_policy_attachment.shop_eks_policy]
}

resource "aws_iam_role" "shop_eks_role" {
  name = "shop-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "shop_eks_policy" {
  role       = aws_iam_role.shop_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
