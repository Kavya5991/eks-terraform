variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  default = "10.0.0.0/16" 
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_name"{
  type=string
  description="Enter name of cluster"
  default="awseks"
}
variable "enable_cluster_logs"{
 description = "Set to true to enable cluster logs"
  default     = true
}

variable "create_cloudwatch_log_group" {
  type        = bool
  description = "set it to true to create the CloudWatch log group"
  default     = true
}