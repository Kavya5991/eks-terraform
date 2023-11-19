variable "cluster_name" {
  description = "name of cluster"
  type=string
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of  subnet IDs used for cluster"
}