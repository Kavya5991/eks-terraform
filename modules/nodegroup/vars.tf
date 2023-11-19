variable "cluster_name" {
  description = "name of cluster"
  type=string
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of  subnet IDs used for cluster"
}
variable "nodegroup_name"{
  type=string
  description="Enter name of nodegroup"
  default="demo"
}

variable "desired_size" {
  type    = number
  description = "The desired number of nodes in the EKS node group."
  default = 1 # Set a default value or adjust according to your needs
}

variable "min_size" {
  type    = number
  description = "The desired number of nodes in the EKS node group."
  default = 1  # Set a default value or adjust according to your needs
}

variable "max_size" {
  type    = number
  description = "The desired number of nodes in the EKS node group."
  default = 2  # Set a default value or adjust according to your needs
}