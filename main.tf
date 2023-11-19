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
  //count = var.deploy_nginx ? 1 : 0
}


provider "kubernetes" {
  host                   = module.cluster.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster.eks_cluster_certificate_authority_data)
  token                  = module.cluster.eks_access_token
}

module "eks-kubeconfig" {
  source     = "hyperbadger/eks-kubeconfig/aws"
  version    = "1.0.0"
  cluster_id = module.cluster.cluster_id
}
