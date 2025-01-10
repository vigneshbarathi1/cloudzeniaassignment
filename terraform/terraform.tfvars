# AWS Region and Subnet IDs
region             = "us-east-1" # Adjust region
vpc_id             = "vpc-030e76e428b4261de"
private_subnet_ids = ["subnet-0794c77e51004c1b1"]
public_subnet_ids  = ["subnet-0def90a3bd9ce68ea"]
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
