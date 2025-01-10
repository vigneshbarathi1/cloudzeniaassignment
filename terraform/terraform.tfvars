# AWS Region and Subnet IDs
region             = "us-east-1"   # Adjust region
vpc_id             = "10.0.0.0/16" # Replace with your VPC ID
private_subnet_ids = ["10.0.128.0/20"]
public_subnet_ids  = ["10.0.0.0/20"] # s

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
