## eks-terraform
Provision EKS Cluster using terraform Modules to create cluster, Nodegroup, Node and deploy nginx pod using resources block by creating VPC, Subnets(Internet gateway,route tables and their associations), adding required IAM policies and roles.
Implemented Logical sequence to enable Cloudwatch log group and also run specific modules during terraform apply.


## Command:
terraform apply -var="nginx_deploy=true" 
