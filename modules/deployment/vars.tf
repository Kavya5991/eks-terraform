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
