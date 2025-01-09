# AWS Region and Subnet IDs
region             = "us-east-1"                            # Adjust region
vpc_id             = "vpc-xxxxxxxx"                         # Replace with your VPC ID
private_subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"] # Replace with your private subnet IDs
public_subnet_ids  = ["subnet-zzzzzzzz", "subnet-wwwwwwww"] # Replace with your public subnet IDs

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
