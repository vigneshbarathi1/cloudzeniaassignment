# VPC and Subnet ID
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# Domain name
variable "domain_name" {
  description = "Base domain name for ALB listeners"
  type        = string
  default     = "cloudzenassign.com"
}

# WordPress settings
variable "wordpress_image" {
  description = "Docker image for WordPress"
  type        = string
  default     = "wordpress:latest"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "wordpress-cluster"
}

variable "ecs_service_name" {
  description = "ECS Service Name"
  type        = string
  default     = "wordpress-service"
}

# RDS
variable "db_username" {
  description = "Database username"
  type        = string
  default     = "wordpress_user"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "secure_password"
}
