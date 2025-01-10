# AWS Region and Subnet IDs
region             = "us-east-1"   # Adjust region
vpc_id             = "vpc-1234567890abcdef0" VPC ID
private_subnet_ids = ["subnet-9876543210abcdef0", "subnet-0123456789abcdef0"]
public_subnet_ids  = ["subnet-fedcba9876543210"]

# Domain Name
domain_name = "cloudzenassign.com"

# RDS Database Username and Password
db_username = "wordpress_user"
db_password = "secure_password" # Use a strong password here

# ECS Cluster and Service Names
ecs_cluster_name = "wordpress-cluster"
ecs_service_name = "wordpress-service"

# WordPress Image
wordpress_image = "wordpress:latest"
