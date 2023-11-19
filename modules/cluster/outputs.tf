output "eks_cluster_endpoint" {
  value = aws_eks_cluster.awseks.endpoint
}
output "eks_cluster_certificate_authority_data" {
  value = aws_eks_cluster.awseks.certificate_authority[0].data
}

output "eks_access_token" {
  value = aws_eks_cluster.awseks.identity[0].oidc[0].issuer
}

output "eks_cluster_name" {
  value = aws_eks_cluster.awseks.name
}

output "subnet_ids" {
  value = aws_subnet.public_subnet[*].id  
}


output "cluster_id" {
  value = aws_eks_cluster.awseks.id
}
