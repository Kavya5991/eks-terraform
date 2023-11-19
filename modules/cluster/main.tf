resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.eks_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.example.id
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
   tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

  resource "aws_route_table_association" "public_route_association" {
    count = length(var.availability_zones)
    subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
    route_table_id = aws_route_table.public_route_table.id
  }

# Create EKS Cluster
resource "aws_eks_cluster" "awseks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.example.arn
  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
  enabled_cluster_log_types = var.enable_cluster_logs ? ["api", "audit","controllerManager","scheduler"] : []


  
}

resource "aws_cloudwatch_log_group" "example" {
  count             = var.create_cloudwatch_log_group ? 1 : 0
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}



variable "create_cloudwatch_log_group" {
  type        = bool
  description = "Whether to create the CloudWatch log group"
  default     = true
}

# Outputs

# IAM Policy Document for AssumeRole
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
# IAM Role for EKS Cluster
resource "aws_iam_role" "example" {
  name               = "eks-cluster-demo"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# IAM Role Policy Attachments
resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example.name
}
resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.example.name
}
