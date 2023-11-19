module "cluster" {
  source                = "./modules/cluster"
}


module "nodegroup" {
  source                = "./modules/nodegroup"
  cluster_name   = module.cluster.eks_cluster_name
  subnet_ids = module.cluster.subnet_ids

}
module "deployment" {
  source                = "./modules/deployment"
  count = var.nginx_deploy ? 1 : 0
}

data "aws_eks_cluster" "example" {
  name = module.cluster.eks_cluster_name
  depends_on=[module.cluster]
}

data "aws_eks_cluster_auth" "example" {
    name = module.cluster.eks_cluster_name
    depends_on=[module.cluster]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.example.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.example.token
}
