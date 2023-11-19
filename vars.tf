variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  default = "10.0.0.0/16" 
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "nginx_deploy"{
 description = "Set to true to deploy nginx pod on top of node"
  default     = true
}


/*variable "subnet_ids" {
  type        = list(string)
  description = "The list of  subnet IDS"
}*/