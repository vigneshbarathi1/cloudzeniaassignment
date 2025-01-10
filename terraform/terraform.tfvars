# AWS Region and Subnet IDs
region             = "us-east-1" # Adjust region
vpc_id             = "vpc-03cb4b21ab8e99f2c"
private_subnet_ids = ["subnet-0e9c27f7555a2bd99", "subnet-00a83b2c94a4e8f47"]
public_subnet_ids  = ["subnet-0e59fdd76d0d8a7f6", "subnet-0aaccdfca31037dc3"]
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
