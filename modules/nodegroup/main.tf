resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = ["eks.amazonaws.com", "ec2.amazonaws.com"]
      },
    }],
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = aws_iam_policy.AmazonEKSWorkerNodePolicy.arn
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = aws_iam_policy.AmazonEKS_CNI_Policy.arn
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = aws_iam_policy.AmazonEC2ContainerRegistryReadOnly.arn
  role       = aws_iam_role.example.name
}

resource "aws_eks_node_group" "example" {
  cluster_name    = var.cluster_name
  node_group_name = "demo"
  node_role_arn   = aws_iam_role.example.arn
  //subnet_ids      = element(var.public_subnet_ids,)
  //count         = length(module.cluster.public_subnet_ids)
  subnet_ids    = var.subnet_ids


  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_policy" "AmazonEKSWorkerNodePolicy" {
  name        = "AmazonEKSWorkerNodePolicy"
  description = "IAM policy for Amazon EKS worker nodes"
  policy = file("modules/nodegroup/policies/EKSWorkerNodePolicy.json")
}

resource "aws_iam_policy" "AmazonEKS_CNI_Policy" {
  name        = "AmazonEKS_CNI_Policy"
  description = "IAM policy for Amazon EKS CNI"
  policy = file("modules/nodegroup/policies/EKS_CNI_Policy.json")
}

resource "aws_iam_policy" "AmazonEC2ContainerRegistryReadOnly" {
  name        = "AmazonEC2ContainerRegistryReadOnly"
  description = "IAM policy for read-only access to Amazon ECR"
  policy = file("modules/nodegroup/policies/EC2ContainerRegistryReadOnly.json")
}

data "aws_iam_policy" "AmazonEKSServicePolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_policy_attachment" "example-AmazonEKSServicePolicy" {
  name       = "AmazonEKSServicePolicy"
  policy_arn = data.aws_iam_policy.AmazonEKSServicePolicy.arn
  roles      = [aws_iam_role.example.name]
}

data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_policy_attachment" "example-AmazonEKSClusterPolicy" {
  name       = "AmazonEKSClusterPolicy"
  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
  roles      = [aws_iam_role.example.name]
}

data "aws_iam_policy" "AmazonEKSVPCResourceController" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}
resource "aws_iam_policy_attachment" "example-AmazonEKSVPCResourceController" {
   name       = "AmazonEKSVPCResourceController"
  policy_arn = data.aws_iam_policy.AmazonEKSVPCResourceController.arn
  roles       = [aws_iam_role.example.name]
}
