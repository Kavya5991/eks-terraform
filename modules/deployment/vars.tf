variable "nginx_replicas" {
 
  type        = number
  default     = 2
description = "Replica count for the Nginx deployment"
}

variable "nginx_image" {
 
  type        = string
  default     = "nginx:latest"
  description = "Docker image for Nginx from ECR"
}

# vars.tf

variable "max_surge_percentage" {
  type    = string
  default = "25%"
}

variable "max_unavailable_percentage" {
  type    = string
  default = "25%"
}


# vars.tf

variable "container_name" {
  type    = string
  default = "nginx-container"
}

variable "label_name" {
  type    = string
  default = "nginx-app"
}

variable "deploy_name" {
  type    = string
  default = "nginx-deploy"
}
