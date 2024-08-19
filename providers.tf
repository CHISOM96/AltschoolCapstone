provider "aws" {
  region = "us-east-1" # Change this to your preferred region
}

provider "kubernetes" {
  host                   = aws_eks_cluster.shop_eks.endpoint
  token                  = data.aws_eks_cluster_auth.shop_eks_auth.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.shop_eks.certificate_authority[0].data)
}

